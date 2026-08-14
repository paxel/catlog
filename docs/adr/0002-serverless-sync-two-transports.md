# Serverless sync: LAN device-to-device first, shared cloud folder second

There is no central service — nothing to pay for, operate, or breach. Devices sync by delta exchange: each device keeps its own append-only log, peers tell each other the newest entry they hold from each log, and only missing entries (and image blobs) transfer. Transport one is direct device-to-device on LAN/hotspot (works at the foster home, zero third parties); transport two, added later, is a shared folder on a cloud drive the group already has (Google Drive/iCloud/Dropbox) used as a dumb file store, which covers syncing while geographically apart. Both transports move the same data, so the file/entry layout is transport-agnostic.

## Considered Options

- Central server (rejected: cost, operations, attack surface — explicitly unwanted).
- Syncthing underneath (rejected: effectively unavailable on iOS, and the primary user's phone is an iPhone).
- Cloud folder first (rejected in ordering only: LAN was preferred first; the trade-off accepted is no sync while apart until the cloud transport ships).
