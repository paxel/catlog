//! Desktop notifications for reminders while the app runs: the system's
//! notification service outside tests, a recorder inside.

/// Shows one notification.
pub trait Notifier {
    fn notify(&mut self, title: &str, body: &str);
}

/// The platform notification service.
pub struct DesktopNotifier;

impl Notifier for DesktopNotifier {
    fn notify(&mut self, title: &str, body: &str) {
        let shown = notify_rust::Notification::new()
            .summary(title)
            .body(body)
            .appname(catlog_core::APP_NAME)
            .show();
        if let Err(e) = shown {
            eprintln!("catlog: notification: {e}");
        }
    }
}

/// Keeps what would have been shown, readable from outside.
#[derive(Debug, Default)]
pub struct RecordingNotifier {
    pub shown: std::sync::Arc<std::sync::Mutex<Vec<(String, String)>>>,
}

impl Notifier for RecordingNotifier {
    fn notify(&mut self, title: &str, body: &str) {
        if let Ok(mut shown) = self.shown.lock() {
            shown.push((title.to_string(), body.to_string()));
        }
    }
}
