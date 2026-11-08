# Changelog

Each section is a version of the mod, the `version` in `mod.json`. The release workflow copies the
section of a tagged version into the release notes.

## 1.1.0

Needs loader 2.17.0.

- Previous Page and Next Page are made in Lua on the skill window (`rq.gamebutton`'s
  `"skill-window"` group) instead of the engine's C. They look the same and sit a little lower,
  under the list's picture (y 660 instead of 652).
- The arrow keys reach them: Down from a column's last skill.
- Each shows a tip with the page, "Page 2 of 3".
- The agent controls are now `potential-skill-pages.prev` and `potential-skill-pages.next`
  (were `skill-page-prev` and `skill-page-next`).

## 1.0.0

First version.

- Pages of 36 on the Potential Skills list, with Previous Page and Next Page. Page 1 on open; a
  click that would leave the list is denied.
- The page buttons are registered as agent controls (`skill-page-prev`, `skill-page-next`).
