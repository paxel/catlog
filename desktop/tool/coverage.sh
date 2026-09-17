#!/usr/bin/env sh
# Line coverage per crate, each gated at 80%. The binary entry point,
# integration render tests and generated code do not count.
set -eu
cd "$(dirname "$0")/.."
floor="${COVERAGE_FLOOR:-80}"
for crate in catlog-core catlog-gui; do
  others=$(printf 'catlog-core catlog-gui' | tr ' ' '\n' | grep -v "^$crate$" | paste -sd '|' -)
  echo "== $crate (floor $floor%)"
  cargo llvm-cov -p "$crate" \
    --ignore-filename-regex "($others)|/bin/|/tests/|/generated/" \
    --summary-only --fail-under-lines "$floor"
done
