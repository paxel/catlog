import unittest

from whats_new import FULL, LIMIT, whats_new

CHANGELOG = """# Changelog

## [0.2.0] - Unreleased

### Added
- First thing.

### Fixed
- Second thing.

---

Historical changes have been moved to [OLDER_CHANGES.md](OLDER_CHANGES.md).
""".splitlines(keepends=True)


class WhatsNewTest(unittest.TestCase):
    def test_entries_of_the_version_without_headings(self):
        self.assertEqual(whats_new("0.2.0", CHANGELOG), "• First thing.\n• Second thing.")

    def test_a_long_section_is_cut_at_whole_entries_with_a_link(self):
        long = ["## [1.0.0] - Unreleased\n"] + [f"- {'x' * 100} {i}\n" for i in range(10)]
        text = whats_new("1.0.0", long)
        self.assertLessEqual(len(text), 500)
        self.assertTrue(text.endswith(FULL))
        self.assertTrue(all(line.startswith("• ") or line == FULL for line in text.split("\n")))

    def test_an_unknown_version_gives_nothing(self):
        self.assertEqual(whats_new("9.9.9", CHANGELOG), "")


if __name__ == "__main__":
    unittest.main()
