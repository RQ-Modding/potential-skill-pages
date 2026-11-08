# Testing Potential Skill Pages

For people and agents who test the mod in the game. Read it before you use anything the mod adds. If this file is missing, or `potential-skill-pages.prev` / `potential-skill-pages.next` are not in `rqmod-ctl ui` with the Potential Skills window open, the page buttons are not there. Do not assume them.

## When the buttons exist

The buttons exist only while the Potential Skills window is open (status → Skills). The window makes them again on every build of its list (open, a buy, a character change, a page) and destroys them when it closes. `rqmod-ctl ui` lists them only while the window is up. `hover` / `press` fail with `unknown-control` after it closes.

A grey button is still listed, with `enabled` false. A grey click is the game's deny sound and does not change the page. Do not expect `hover` or `press` to land on a grey button; use `enabled` to see that it is grey, or click its place.

## Control ids

| id | label | role |
| --- | --- | --- |
| `potential-skill-pages.prev` | Previous Page | one page toward page 1 |
| `potential-skill-pages.next` | Next Page | one page toward the last page |

They are `rq.gamebutton` entries of the `"skill-window"` group (loader 2.17.0), registered with `rq.agent.control` as `<mod>.<id>` on each build. Up to 1.0.0 they were `skill-page-prev` / `skill-page-next`.

## Layout

36 skills per page, in an 18×2 grid. The buttons are the group's first row, under the list's picture: Previous at x 531, Next at x 745, both at **y 660** (206 × 30). Another mod's `"skill-window"` buttons go after them, the next at y 692. Confirm `x` / `y` from the live `ui` row, or from `rq.gamebutton.groups()`.

## Keys

- Down from the last skill of a column goes to the button under that column; a grey one is skipped (Previous is grey on page 1, so Down from the left column reaches Next).
- From a button: Up goes to the last skill of its column, Down to the first (as the list wraps), Left / Right to the other button of the row if it is not grey.
- Enter on a button presses it.

## Page rules

- Open starts at page 1. Previous is grey on page 1, Next on the last page. On a one-page list both are grey.
- Buying a skill does not jump back to page 1. Closing and opening the menu does.
- Under the mouse or the keys, a button shows the game's comment: its label and "Page N of M".
- `rq.skilllist.page()` and `page_count()` give the page; `skillShop.page` / `skillShop.pages` in `rqmod-ctl ui` too.

## Wichita

Spellblade Knowledge is skill **960**. On Wichita it is registered after the first 36 unowned offers, so it is on **page 2** when page 1 is full. Press `potential-skill-pages.next`, then buy the `offer-N` whose `value` is `960`.

## When you change the mod

Keep this file in step with `init.lua`, not with memory or the game's code:

- The ids are the `id` fields given to `rq.gamebutton.add`, with the mod's id in front.
- `enabled` asks `rq.skilllist.page()` and `page_count()`; it also sets the tip.
- `on_click` sets the page and calls `rq.skilllist.refresh()`.
- The page length (36) is the engine's (`rq.skilllist`); the places are `rq.gamebutton`'s.
