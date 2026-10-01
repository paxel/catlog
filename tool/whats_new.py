"""Prints F-Droid's "What's new" for a version from CHANGELOG.md.

    python3 tool/whats_new.py 0.1.0 CHANGELOG.md

F-Droid cuts that text at 500 characters, so headings are dropped, whole
entries are kept while they fit, and a cut list ends with a link to the
full changelog.
"""
import sys

LIMIT = 440
FULL = "All changes: https://github.com/paxel/catlog/blob/HEAD/CHANGELOG.md"


def section(version, lines):
    grab = False
    for line in lines:
        if line.startswith(f"## [{version}]"):
            grab = True
            continue
        if grab and (line.startswith("## [") or line.startswith("---")):
            return
        if grab:
            yield line.rstrip("\n")


def whats_new(version, lines):
    entries = [
        "• " + line[2:].strip()
        for line in section(version, lines)
        if line.startswith("- ")
    ]
    kept = []
    for entry in entries:
        if len("\n".join(kept + [entry])) > LIMIT:
            return "\n".join(kept + [FULL])
        kept.append(entry)
    return "\n".join(kept)


if __name__ == "__main__":
    with open(sys.argv[2], encoding="utf-8") as f:
        print(whats_new(sys.argv[1], f.readlines()))
