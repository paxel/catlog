//! The subset of ICU message syntax the ARB files use: `{name}`
//! arguments, `{n, plural, =0{...} one{...} other{...}}` and
//! `{s, select, a{...} other{...}}`, with `#` inside a plural form
//! standing for the number. Apostrophes are plain text, as in the
//! phone app.

/// A value for a placeholder.
#[derive(Debug, Clone, Copy, PartialEq)]
pub enum Arg<'a> {
    Str(&'a str),
    Int(i64),
}

impl Arg<'_> {
    fn text(&self) -> String {
        match self {
            Arg::Str(s) => s.to_string(),
            Arg::Int(n) => n.to_string(),
        }
    }

    fn number(&self) -> Option<i64> {
        match self {
            Arg::Int(n) => Some(*n),
            Arg::Str(s) => s.trim().parse().ok(),
        }
    }
}

/// What kind of argument a message uses a variable as.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum VariableKind {
    Plain,
    Plural,
    Select,
}

/// Every variable a message names, in order of first appearance.
pub fn variables(message: &str) -> Vec<(String, VariableKind)> {
    let mut out: Vec<(String, VariableKind)> = Vec::new();
    for part in parse(message) {
        collect(&part, &mut out);
    }
    out
}

fn collect(part: &Part, out: &mut Vec<(String, VariableKind)>) {
    let add = |name: &str, kind: VariableKind, out: &mut Vec<(String, VariableKind)>| match out
        .iter_mut()
        .find(|(n, _)| n == name)
    {
        Some(slot) if kind != VariableKind::Plain => slot.1 = kind,
        Some(_) => {}
        None => out.push((name.to_string(), kind)),
    };
    match part {
        Part::Text(_) | Part::Hash => {}
        Part::Var(name) => add(name, VariableKind::Plain, out),
        Part::Plural(name, forms) => {
            add(name, VariableKind::Plural, out);
            for (_, body) in forms {
                for p in body {
                    collect(p, out);
                }
            }
        }
        Part::Select(name, forms) => {
            add(name, VariableKind::Select, out);
            for (_, body) in forms {
                for p in body {
                    collect(p, out);
                }
            }
        }
    }
}

#[derive(Debug, Clone, PartialEq)]
enum Part {
    Text(String),
    Var(String),
    Hash,
    Plural(String, Vec<(String, Vec<Part>)>),
    Select(String, Vec<(String, Vec<Part>)>),
}

fn parse(message: &str) -> Vec<Part> {
    let chars: Vec<char> = message.chars().collect();
    let mut pos = 0;
    parse_parts(&chars, &mut pos, false)
}

/// Parses until the end or, inside a form, until the closing brace.
fn parse_parts(chars: &[char], pos: &mut usize, in_form: bool) -> Vec<Part> {
    let mut parts = Vec::new();
    let mut text = String::new();
    while *pos < chars.len() {
        let c = chars[*pos];
        if in_form && c == '}' {
            break;
        }
        if c == '{' {
            if !text.is_empty() {
                parts.push(Part::Text(std::mem::take(&mut text)));
            }
            *pos += 1;
            parts.push(parse_argument(chars, pos));
            continue;
        }
        if in_form && c == '#' {
            if !text.is_empty() {
                parts.push(Part::Text(std::mem::take(&mut text)));
            }
            parts.push(Part::Hash);
            *pos += 1;
            continue;
        }
        text.push(c);
        *pos += 1;
    }
    if !text.is_empty() {
        parts.push(Part::Text(text));
    }
    parts
}

/// After an opening brace: `name}` or `name, plural, forms}`.
fn parse_argument(chars: &[char], pos: &mut usize) -> Part {
    let mut name = String::new();
    while *pos < chars.len() && chars[*pos] != '}' && chars[*pos] != ',' {
        name.push(chars[*pos]);
        *pos += 1;
    }
    let name = name.trim().to_string();
    if *pos >= chars.len() || chars[*pos] == '}' {
        *pos += 1;
        return Part::Var(name);
    }
    *pos += 1; // the comma
    let mut kind = String::new();
    while *pos < chars.len() && chars[*pos] != ',' && chars[*pos] != '}' {
        kind.push(chars[*pos]);
        *pos += 1;
    }
    if *pos < chars.len() && chars[*pos] == ',' {
        *pos += 1;
    }
    let mut forms = Vec::new();
    loop {
        while *pos < chars.len() && chars[*pos].is_whitespace() {
            *pos += 1;
        }
        if *pos >= chars.len() || chars[*pos] == '}' {
            *pos += 1;
            break;
        }
        let mut selector = String::new();
        while *pos < chars.len() && chars[*pos] != '{' && chars[*pos] != '}' {
            selector.push(chars[*pos]);
            *pos += 1;
        }
        if *pos >= chars.len() || chars[*pos] == '}' {
            *pos += 1;
            break;
        }
        *pos += 1; // the form's opening brace
        let body = parse_parts(chars, pos, true);
        *pos += 1; // the form's closing brace
        forms.push((selector.trim().to_string(), body));
    }
    match kind.trim() {
        "plural" => Part::Plural(name, forms),
        "select" => Part::Select(name, forms),
        _ => Part::Var(name),
    }
}

/// Formats `message` for `locale` with `args`. A missing argument
/// renders as its name in braces, so a gap is visible, never a crash.
pub fn format(locale: &str, message: &str, args: &[(&str, Arg)]) -> String {
    let mut out = String::new();
    for part in parse(message) {
        render(locale, &part, args, None, &mut out);
    }
    out
}

fn render(locale: &str, part: &Part, args: &[(&str, Arg)], hash: Option<i64>, out: &mut String) {
    let lookup = |name: &str| args.iter().find(|(n, _)| *n == name).map(|(_, a)| *a);
    match part {
        Part::Text(t) => out.push_str(t),
        Part::Hash => match hash {
            Some(n) => out.push_str(&n.to_string()),
            None => out.push('#'),
        },
        Part::Var(name) => match lookup(name) {
            Some(a) => out.push_str(&a.text()),
            None => {
                out.push('{');
                out.push_str(name);
                out.push('}');
            }
        },
        Part::Plural(name, forms) => {
            let n = lookup(name).and_then(|a| a.number());
            let chosen = match n {
                Some(n) => {
                    let exact = format!("={n}");
                    let category = plural_category(locale, n);
                    forms
                        .iter()
                        .find(|(s, _)| *s == exact)
                        .or_else(|| forms.iter().find(|(s, _)| *s == category))
                        .or_else(|| forms.iter().find(|(s, _)| s == "other"))
                }
                None => forms.iter().find(|(s, _)| s == "other"),
            };
            if let Some((_, body)) = chosen {
                for p in body {
                    render(locale, p, args, n, out);
                }
            }
        }
        Part::Select(name, forms) => {
            let value = lookup(name).map(|a| a.text());
            let chosen = value
                .as_deref()
                .and_then(|v| forms.iter().find(|(s, _)| s == v))
                .or_else(|| forms.iter().find(|(s, _)| s == "other"));
            if let Some((_, body)) = chosen {
                for p in body {
                    render(locale, p, args, hash, out);
                }
            }
        }
    }
}

/// The CLDR plural category of an integer count in `locale`, as the
/// phone app's translations expect it.
pub fn plural_category(locale: &str, n: i64) -> &'static str {
    let n = n.abs();
    let m10 = n % 10;
    let m100 = n % 100;
    let lang = locale.split(['-', '_']).next().unwrap_or(locale);
    match lang {
        "ja" | "zh" => "other",
        "fr" | "pt" | "fa" => {
            if n == 0 || n == 1 {
                "one"
            } else {
                "other"
            }
        }
        "ar" => match n {
            0 => "zero",
            1 => "one",
            2 => "two",
            _ if (3..=10).contains(&m100) => "few",
            _ if (11..=99).contains(&m100) => "many",
            _ => "other",
        },
        "he" => match n {
            1 => "one",
            2 => "two",
            _ if n > 10 && m10 == 0 => "many",
            _ => "other",
        },
        "ru" | "uk" => {
            if m10 == 1 && m100 != 11 {
                "one"
            } else if (2..=4).contains(&m10) && !(12..=14).contains(&m100) {
                "few"
            } else {
                "many"
            }
        }
        "bs" | "hr" | "sr" => {
            if m10 == 1 && m100 != 11 {
                "one"
            } else if (2..=4).contains(&m10) && !(12..=14).contains(&m100) {
                "few"
            } else {
                "other"
            }
        }
        "cs" | "sk" => match n {
            1 => "one",
            2..=4 => "few",
            _ => "other",
        },
        "pl" => {
            if n == 1 {
                "one"
            } else if (2..=4).contains(&m10) && !(12..=14).contains(&m100) {
                "few"
            } else {
                "many"
            }
        }
        "lt" => {
            if m10 == 1 && !(11..=19).contains(&m100) {
                "one"
            } else if (2..=9).contains(&m10) && !(11..=19).contains(&m100) {
                "few"
            } else {
                "other"
            }
        }
        "lv" => {
            if m10 == 0 || (11..=19).contains(&m100) {
                "zero"
            } else if m10 == 1 && m100 != 11 {
                "one"
            } else {
                "other"
            }
        }
        "ga" => match n {
            1 => "one",
            2 => "two",
            3..=6 => "few",
            7..=10 => "many",
            _ => "other",
        },
        "mt" => match n {
            1 => "one",
            0 => "few",
            _ if (2..=10).contains(&m100) => "few",
            _ if (11..=19).contains(&m100) => "many",
            _ => "other",
        },
        "ro" => match n {
            1 => "one",
            0 => "few",
            _ if (2..=19).contains(&m100) => "few",
            _ => "other",
        },
        "sl" => match m100 {
            1 => "one",
            2 => "two",
            3 | 4 => "few",
            _ => "other",
        },
        "mk" | "is" => {
            if m10 == 1 && m100 != 11 {
                "one"
            } else {
                "other"
            }
        }
        _ => {
            if n == 1 {
                "one"
            } else {
                "other"
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn arguments_plurals_and_selects_format() {
        assert_eq!(
            format("en", "CSV saved to {path}", &[("path", Arg::Str("/tmp/x"))]),
            "CSV saved to /tmp/x"
        );
        assert_eq!(format("en", "Hello {name}", &[]), "Hello {name}");
        let msg = "{n, plural, =0{Nothing restored.} one{1 catalog restored.} other{{n} catalogs restored.}}";
        assert_eq!(
            format("en", msg, &[("n", Arg::Int(0))]),
            "Nothing restored."
        );
        assert_eq!(
            format("en", msg, &[("n", Arg::Int(1))]),
            "1 catalog restored."
        );
        assert_eq!(
            format("en", msg, &[("n", Arg::Int(3))]),
            "3 catalogs restored."
        );
        assert_eq!(
            format("en", msg, &[("n", Arg::Str("2"))]),
            "2 catalogs restored."
        );
        assert_eq!(format("en", msg, &[]), "{n} catalogs restored.");
        assert_eq!(
            format(
                "en",
                "{n, plural, one{# day} other{# days}}",
                &[("n", Arg::Int(2))]
            ),
            "2 days"
        );
        assert_eq!(
            format(
                "en",
                "{n, plural, one{one} other{many}} left",
                &[("n", Arg::Int(5))]
            ),
            "many left"
        );
        let sel = "{g, select, female{she} male{he} other{they}} did it";
        assert_eq!(format("en", sel, &[("g", Arg::Str("male"))]), "he did it");
        assert_eq!(format("en", sel, &[("g", Arg::Str("x"))]), "they did it");
        assert_eq!(format("en", sel, &[]), "they did it");
        assert_eq!(
            format(
                "en",
                "it's {a} and {b, number}",
                &[("a", Arg::Int(1)), ("b", Arg::Int(2))]
            ),
            "it's 1 and 2"
        );
        assert_eq!(
            format("en", "{n, plural, one{x}}", &[("n", Arg::Int(3))]),
            ""
        );
        assert_eq!(
            format("en", "broken {n, plural, one{x", &[("n", Arg::Int(1))]),
            "broken x"
        );
        assert_eq!(format("en", "# outside", &[]), "# outside");
    }

    #[test]
    fn variables_are_found_with_their_kind() {
        let vars = variables(
            "{n, plural, one{{n} for {who}} other{#}} and {who} {g, select, a{x} other{y}}",
        );
        assert_eq!(
            vars,
            vec![
                ("n".to_string(), VariableKind::Plural),
                ("who".to_string(), VariableKind::Plain),
                ("g".to_string(), VariableKind::Select),
            ]
        );
        assert_eq!(
            variables("{x} then {x, plural, other{y}}")[0].1,
            VariableKind::Plural
        );
    }

    #[test]
    fn plural_categories_follow_cldr_for_every_app_locale() {
        assert_eq!(plural_category("en", 1), "one");
        assert_eq!(plural_category("en", 0), "other");
        assert_eq!(plural_category("de-DE", 5), "other");
        assert_eq!(plural_category("fr", 0), "one");
        assert_eq!(plural_category("fr", 2), "other");
        assert_eq!(plural_category("ja", 1), "other");
        assert_eq!(plural_category("ar", 0), "zero");
        assert_eq!(plural_category("ar", 2), "two");
        assert_eq!(plural_category("ar", 5), "few");
        assert_eq!(plural_category("ar", 15), "many");
        assert_eq!(plural_category("ar", 100), "other");
        assert_eq!(plural_category("he", 2), "two");
        assert_eq!(plural_category("he", 20), "many");
        assert_eq!(plural_category("he", 3), "other");
        assert_eq!(plural_category("ru", 21), "one");
        assert_eq!(plural_category("ru", 22), "few");
        assert_eq!(plural_category("ru", 12), "many");
        assert_eq!(plural_category("uk", 11), "many");
        assert_eq!(plural_category("hr", 5), "other");
        assert_eq!(plural_category("sr", 3), "few");
        assert_eq!(plural_category("cs", 3), "few");
        assert_eq!(plural_category("sk", 5), "other");
        assert_eq!(plural_category("pl", 22), "few");
        assert_eq!(plural_category("pl", 5), "many");
        assert_eq!(plural_category("pl", 1), "one");
        assert_eq!(plural_category("lt", 11), "other");
        assert_eq!(plural_category("lt", 22), "few");
        assert_eq!(plural_category("lt", 21), "one");
        assert_eq!(plural_category("lv", 0), "zero");
        assert_eq!(plural_category("lv", 21), "one");
        assert_eq!(plural_category("lv", 2), "other");
        assert_eq!(plural_category("ga", 4), "few");
        assert_eq!(plural_category("ga", 8), "many");
        assert_eq!(plural_category("ga", 2), "two");
        assert_eq!(plural_category("mt", 0), "few");
        assert_eq!(plural_category("mt", 15), "many");
        assert_eq!(plural_category("mt", 1), "one");
        assert_eq!(plural_category("mt", 25), "other");
        assert_eq!(plural_category("ro", 5), "few");
        assert_eq!(plural_category("ro", 25), "other");
        assert_eq!(plural_category("sl", 101), "one");
        assert_eq!(plural_category("sl", 102), "two");
        assert_eq!(plural_category("sl", 3), "few");
        assert_eq!(plural_category("sl", 5), "other");
        assert_eq!(plural_category("mk", 11), "other");
        assert_eq!(plural_category("is", 21), "one");
        assert_eq!(plural_category("hu", 1), "one");
        assert_eq!(plural_category("tr", -1), "one");
    }
}
