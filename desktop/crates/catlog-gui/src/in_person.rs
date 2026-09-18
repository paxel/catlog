//! In person (#138): the desk hosts a sync session for a phone in the
//! same room, as one phone hosts for another. The modal shows the pair
//! code as a QR and as text, the PIN, the private switch and how many
//! sessions came by; every unknown phone gets the keeper's question.
//! The host serves only while the modal is open.

use std::collections::VecDeque;
use std::net::IpAddr;

use catlog_core::Catalog;
use catlog_core::lan::{Host, JoinAsk, JoinDecision, Request, Response, Served, Session};
use egui::{Context, Ui};

use crate::codes;
use crate::icons;
use crate::l10n::L10n;
use crate::theme::PALETTE;

/// What the keeper did in the modal this frame.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum InPersonAction {
    None,
    /// Stop hosting and close the modal.
    Stop,
    /// Put the typed code on the clipboard.
    Copy(String),
}

/// The desk's hosting state.
#[derive(Default)]
pub struct InPerson {
    pub host: Option<Host>,
    /// Whether private values go out, read at every session; never
    /// persisted, off at every start like the phone's switch.
    pub include_private: bool,
    /// Joiners that completed a session since hosting started.
    pub sessions: u32,
    /// A `/sync` waiting for the keeper's answer.
    pub asking: Option<(Request, JoinAsk)>,
    /// Requests behind it.
    queue: VecDeque<Request>,
    /// Counts the questions, so each one is a modal of its own.
    asked: u32,
    /// The code was copied this session.
    pub copied: bool,
    /// Why hosting could not start, or what a session choked on.
    pub error: Option<String>,
    /// The address to bind instead of the LAN one; tests use the loopback.
    pub bind: Option<IpAddr>,
    /// No local network was found: the host listens on the loopback,
    /// which no phone reaches.
    pub no_network: bool,
    /// How often the phones' requests are looked for while hosting. A
    /// delay under the harness's frame time counts as immediate there,
    /// so tests set it long and step the frames themselves.
    pub poll_every: Option<std::time::Duration>,
}

impl InPerson {
    /// Starts serving with a fresh PIN and this Catalog's certificate.
    pub fn start(&mut self, store: &Catalog) {
        self.stop();
        self.error = None;
        self.copied = false;
        self.include_private = false;
        self.no_network = self.bind.is_none() && catlog_core::lan::lan_address().is_none();
        match store
            .tls_identity()
            .and_then(|identity| Host::start(&identity, &catlog_core::lan::new_pin(), self.bind))
        {
            Ok(host) => self.host = Some(host),
            Err(e) => self.error = Some(e.to_string()),
        }
    }

    /// Stops serving; a question still open is declined.
    pub fn stop(&mut self) {
        if let Some((request, _)) = self.asking.take() {
            request.reply(Response::text(403, "declined"));
        }
        for request in self.queue.drain(..) {
            request.reply(Response::status(503));
        }
        if let Some(mut host) = self.host.take() {
            host.stop();
        }
        self.sessions = 0;
    }

    pub fn hosting(&self) -> bool {
        self.host.is_some()
    }

    /// The wait between two looks for requests.
    pub fn poll_delay(&self) -> std::time::Duration {
        self.poll_every
            .unwrap_or(std::time::Duration::from_millis(100))
    }

    /// Answers what the phones sent since last frame; a `/sync` from an
    /// unknown phone becomes the question, and further syncs wait
    /// behind it. The sessions completed come back for the summary.
    pub fn poll(&mut self, store: &mut Catalog) -> Vec<Session> {
        let mut sessions = Vec::new();
        let Some(host) = &self.host else {
            return sessions;
        };
        while let Some(request) = host.next_request() {
            self.queue.push_back(request);
        }
        let mut held = VecDeque::new();
        while let Some(request) = self.queue.pop_front() {
            let is_sync = request.method == "POST" && request.path == "/sync";
            if is_sync && self.asking.is_some() {
                held.push_back(request);
                continue;
            }
            match store.serve(&request, self.include_private) {
                Ok(Served::Reply(response, session)) => {
                    request.reply(response);
                    sessions.extend(session);
                }
                Ok(Served::Ask(ask)) => {
                    self.asked += 1;
                    self.asking = Some((request, ask));
                }
                Err(e) => {
                    request.reply(Response::status(500));
                    self.error = Some(e.to_string());
                }
            }
        }
        self.queue = held;
        self.sessions += sessions.len() as u32;
        sessions
    }

    /// The keeper answered the question: the joiner is served or turned
    /// away.
    pub fn decide(&mut self, store: &mut Catalog, decision: JoinDecision) -> Option<Session> {
        let (request, ask) = self.asking.take()?;
        match store.serve_join(&ask, decision, self.include_private) {
            Ok((response, session)) => {
                request.reply(response);
                if session.is_some() {
                    self.sessions += 1;
                }
                session
            }
            Err(e) => {
                request.reply(Response::status(500));
                self.error = Some(e.to_string());
                None
            }
        }
    }

    /// The modal's content.
    pub fn show(&mut self, ui: &mut Ui, t: &L10n) -> InPersonAction {
        let mut action = InPersonAction::None;
        ui.set_min_width(420.0);
        ui.set_max_width(520.0);
        ui.heading(t.sync_chooser_in_person());
        ui.add_space(4.0);
        ui.label(t.host_explainer());
        if let Some(error) = &self.error {
            ui.colored_label(PALETTE.red, error);
        }
        let Some(host) = &self.host else {
            return action;
        };
        if self.no_network {
            ui.colored_label(PALETTE.red, t.connect_to_wifi_first());
        }
        ui.add_space(8.0);
        ui.vertical_centered(|ui| {
            codes::qr(ui, &host.pair_code(false), 240.0);
            ui.add_space(8.0);
            let typed = host.pair_code(true);
            for line in catlog_core::lan::pair_code_lines(&typed) {
                ui.label(egui::RichText::new(line).monospace().strong().size(20.0));
            }
            ui.add_space(4.0);
            ui.label(egui::RichText::new(format!("{}:{}", host.address(), host.port())).weak());
            ui.label(egui::RichText::new(t.pin_label(host.pin())).strong());
            ui.add_space(4.0);
            ui.horizontal(|ui| {
                if icons::button(ui, icons::QR_CODE, t.copy_code()).clicked() {
                    action = InPersonAction::Copy(typed.clone());
                    self.copied = true;
                }
                if self.copied {
                    ui.label(egui::RichText::new(t.copied()).weak());
                }
            });
        });
        ui.add_space(8.0);
        ui.checkbox(&mut self.include_private, t.include_private());
        ui.label(t.sessions_so_far(i64::from(self.sessions)));
        if host.locked_out() {
            ui.colored_label(PALETTE.red, t.host_locked_out());
        }
        ui.add_space(8.0);
        if ui.button(t.stop_hosting()).clicked() {
            action = InPersonAction::Stop;
        }
        action
    }

    /// The trust question over the modal, while a phone waits for it.
    pub fn show_question(&mut self, ctx: &Context, t: &L10n) -> Option<JoinDecision> {
        let (_, ask) = self.asking.as_ref()?;
        let mut decision = None;
        let modal =
            egui::Modal::new(egui::Id::new(("trust-question", self.asked))).show(ctx, |ui| {
                ui.set_min_width(360.0);
                ui.heading(t.trust_question(&ask.author, &ask.device_name));
                ui.add_space(4.0);
                ui.label(t.trust_both_ways_note());
                ui.add_space(12.0);
                ui.horizontal(|ui| {
                    if ui.button(t.decline_action()).clicked() {
                        decision = Some(JoinDecision {
                            allow: false,
                            remember: false,
                        });
                    }
                    if ui.button(t.allow_always()).clicked() {
                        decision = Some(JoinDecision {
                            allow: true,
                            remember: true,
                        });
                    }
                    if ui.button(t.allow_once()).clicked() {
                        decision = Some(JoinDecision {
                            allow: true,
                            remember: false,
                        });
                    }
                });
            });
        if decision.is_none() && modal.should_close() {
            decision = Some(JoinDecision {
                allow: false,
                remember: false,
            });
        }
        if decision.is_some() {
            ctx.request_repaint();
        }
        decision
    }
}
