#!/usr/bin/env sh
# Line coverage per crate, each gated at 80%. The binary entry point,
# integration render tests and generated code do not count.
set -eu
cd "$(dirname "$0")/.."
floor="${COVERAGE_FLOOR:-80}"
# Profiles of an earlier run (an example, a render test) would count as
# uncovered copies of the same code.
cargo llvm-cov clean --workspace
crates='catlog-core catlog-l10n catlog-gui'
for crate in $crates; do
  others=$(printf '%s' "$crates" | tr ' ' '\n' | grep -v "^$crate$" | paste -sd '|' -)
  echo "== $crate (floor $floor%)"
  cargo llvm-cov -p "$crate" --lib --tests \
    --ignore-filename-regex "($others)|/bin/|/tests/|/generated/|/target/" \
    --summary-only --fail-under-lines "$floor"
done
