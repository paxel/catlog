# Spec: M4 — i18n, crop, mark

Status: ready-for-agent

## Problem Statement

The app speaks English only — but the people most likely to foster street cats across Europe are exactly the people least likely to read English UI. And a photo of a litter does not say which kitten the card is about: the fosterer needs to cut the right cat out, or point at it when cats overlap.

## Solution

Full localization: ~36 languages (all EU languages plus European non-EU, Ukrainian/Russian/Turkish prioritized for quality, plus Chinese, Japanese, Arabic, Farsi, Hebrew with RTL), machine-translated and community-correctable. Starter field names and values translate at display time per ADR-0005; renamed fields show as typed. Photos gain a crop step in the import flow (skippable, Stray Cam skips), crop-later from the photo menu (new copy, original stays), and a marker tool that bakes a highlight into a copy.

## User Stories

1. As a fosterer who reads no English, I want the whole app in my language, so that I can use it at all.
2. As an Arabic/Farsi/Hebrew user, I want correct right-to-left layout, so that the app feels native.
3. As a fosterer in a mixed-language group, I want starter fields shown in MY language while my friend sees HER language, so that shared data serves both.
4. As a fosterer, I want a renamed field to show exactly as typed for everyone, so that our own vocabulary is never mistranslated.
5. As a contributor, I want translations in simple per-language files, so that fixing a bad string is a one-line pull request.
6. As a fosterer photographing a litter, I want to crop to one cat right when importing, so that the card shows the right kitten.
7. As a fosterer in a hurry, I want to skip cropping (and Stray Cam to never ask), so that capture stays fast.
8. As a fosterer, I want to crop a photo later into a new copy with the original kept, so that one litter photo serves several cats.
9. As a fosterer, I want to mark a cat with a highlight when cropping cannot separate tangled kittens, so that "this one" is unambiguous — also in print.
10. As a fosterer, I want dates shown in my locale's format, so that timelines read naturally.

## Implementation Decisions

- Flutter gen_l10n with ARB files; locale from the system, no in-app picker in v1.
- Language list: EU-24 (bg cs da de el en es et fi fr ga hr hu it lt lv mt nl pl pt ro sk sl sv) + is no sq bs sr mk uk ru tr be? → final: bg bs cs da de el en es et fi fr ga hr hu is it lt lv mk mt nl no pl pt ro ru sk sl sq sr sv tr uk + ar fa he ja zh. Machine-translated; About screen and README state that and link to the repo for corrections.
- Starter field names/values translate at display time keyed by slug and canonical value, only while un-renamed (ADR-0005).
- Crop UI: pure-Flutter cropper (crop_your_image), used in the import flow before compression and from the photo menu afterwards; crop-later appends a new image entry, original stays.
- Marker: draw an ellipse on the photo, bake into a JPEG copy, append as new image entry.
- Timeline/date rendering via intl date formatting per locale.

## Testing Decisions

- Core stays untouched except where crop/mark reuse existing addImage — no new core surface.
- Widget tests: app runs under `de` and `ar` locales (RTL smoke), starter field shows translated name, renamed field shows typed name.
- ARB completeness guarded by gen_l10n (untranslated-messages file must stay empty for the shipped list).
- Crop/mark logic: unit-test the pure image operations (crop rect applied, ellipse baked) on synthetic images; interactive UI verified manually on device.

## Out of Scope

- In-app language picker (system locale only, v1).
- Professional translation review.
- Overlay-data marks (rejected in grilling — baked copies only).
- Translating user-entered content of any kind.

## Further Notes

- ADR-0005 records the display-time translation decision.
- Priority quality pass on: uk, ru, tr, ar, fa (least English exposure).
