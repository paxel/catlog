# iOS signing & TestFlight setup

One-time manual steps to make `.github/workflows/testflight.yml` work.
Everything runs on GitHub's macOS runners — no local Mac needed (ADR-0003).

## Prerequisites

1. Paid Apple Developer Program membership ($99/year).
2. In [App Store Connect](https://appstoreconnect.apple.com):
   - create the app with bundle id `io.github.paxel.catlog`,
   - invite the fosterer as a TestFlight tester.

## Certificates & profile (no Mac: use OpenSSL + the developer portal)

1. Create a key and certificate signing request:

   ```sh
   openssl genrsa -out ios_dist.key 2048
   openssl req -new -key ios_dist.key -out ios_dist.csr \
     -subj "/emailAddress=you@example.org/CN=Patrick Zimmer/C=DE"
   ```

2. In the [developer portal](https://developer.apple.com/account/resources/certificates/list),
   create an **Apple Distribution** certificate from `ios_dist.csr`,
   download `distribution.cer`, then build the `.p12`:

   ```sh
   openssl x509 -in distribution.cer -inform DER -out distribution.pem
   openssl pkcs12 -export -inkey ios_dist.key -in distribution.pem \
     -out distribution.p12   # choose a password
   ```

3. Create an **App Store** provisioning profile for the app id and that
   certificate; download `catlog.mobileprovision`.

4. In App Store Connect → Users and Access → Integrations, create an
   **App Store Connect API key** (App Manager role); note issuer id and
   key id, download the `.p8` once.

## Repository secrets

Under GitHub → Settings → Secrets and variables → Actions, add:

| Secret                     | Content                                  |
| -------------------------- | ---------------------------------------- |
| `IOS_CERTIFICATE_BASE64`   | `base64 -w0 distribution.p12`            |
| `IOS_CERTIFICATE_PASSWORD` | the `.p12` password                      |
| `IOS_PROFILE_BASE64`       | `base64 -w0 catlog.mobileprovision`      |
| `APPSTORE_ISSUER_ID`       | issuer id from the API key page          |
| `APPSTORE_KEY_ID`          | key id of the `.p8`                      |
| `APPSTORE_PRIVATE_KEY`     | full text contents of the `.p8` file     |

## Releasing

Trigger the **TestFlight** workflow manually (workflow_dispatch) or push a
`v*` tag. The build lands in TestFlight; testers get it via the TestFlight
app on their iPhones.
