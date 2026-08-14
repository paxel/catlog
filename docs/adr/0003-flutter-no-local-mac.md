# Flutter single codebase, iOS built in CI without a local Mac

One Flutter/Dart codebase targets all six platforms we need: iPhone (the primary user's device), Android, iPad, Linux, Windows, macOS. Development happens on Linux with an Android device; iOS/iPad builds run on GitHub Actions macOS runners (repo is public, so runner minutes are free) and reach the iPhone via TestFlight under a paid Apple Developer account ($99/year — the only unavoidable cost in the project). Tauri 2 was considered (Rust core appealed) but rejected for less mature mobile tooling; the no-local-Mac constraint is real (only a work Mac exists and it is not usable for this), so we accept that iOS-specific native debugging is harder and keep platform-specific code minimal.

## Consequences

- If the app ever moves from TestFlight to the App Store, external donation links ("buy me a coffee") violate Apple's rules — donations/tips there must be In-App Purchase, or the app can simply be sold for a price.
- SQLite is the local store; OpenStreetMap via flutter_map serves the map (free, no API key).
