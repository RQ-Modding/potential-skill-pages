# Testing Potential Skill Pages

For people and agents who test the mod in the game. Read it before you use anything the mod adds. If this file is missing, or `skill-page-prev` / `skill-page-next` are not in `rqmod-ctl ui`, the page buttons are not there. Do not assume them.

## When the menu exists

The buttons exist only while the Potential Skills window is open (status → Skills). They are destroyed with that window. `rqmod-ctl ui` lists `skill-page-prev` and `skill-page-next` only while those buttons are shown. `hover` / `press` fail with `unknown-control` after the window closes.

A grey arrow is still listed, with `enabled` false. A grey click is the game’s deny sound and does not change the page. Do not expect `hover` to land on a grey arrow; use `enabled` to see that it is grey.

## Control ids

| id | label | role |
| --- | --- | --- |
| `skill-page-prev` | Previous Page | one page toward page 1 |
| `skill-page-next` | Next Page | one page toward the last page |

Registered from `rq.skilllist.on_buttons` via `rq.agent.control`. The numeric button handle is whatever `on_buttons` passes; it is not a fixed constant in the mod.

## Layout

36 skills per page, in an 18×2 grid. Previous Page and Next Page sit at **y = 652**, under the yellow help / stored-points band (that band is about y = 594–634) and above the town system bar (y = 736). Previous is the left column (x = 531). Next is at x = 730 or just to the right of Previous, whichever is further right. Confirm `y` from the live `ui` row if a build moves them.

## Page rules

- Open starts at page 1. Previous is grey on page 1.
- `on_page`: `dir` −1 or +1. A page number changes the page. `false` greys that arrow (deny sound, no second Lua call).
- Both arrows stay visible on a one-page list and both are grey.
- Buying a skill does not jump back to page 1. Closing and opening the menu does.
- `skillShop.page` / `skillShop.pages` in `rqmod-ctl ui` are the engine’s current page while this window is up.

## Wichita

Spellblade Knowledge is skill **960**. On Wichita it is registered after the first 36 unowned offers, so it is on **page 2** when page 1 is full. Press `skill-page-next`, then buy the `offer-N` whose `value` is `960`.

## When you change the mod

Keep this file in step with `init.lua`, not with memory or the game's code:

- The ids come from `rq.skilllist.on_buttons`, which logs the two button handles once
  (`potential-skill-pages: buttons prev=... next=...`).
- `on_page` returns `false` to grey an arrow when the next page would be below 1 or past
  `ctx.pages`, and a page number to move. `on_open` goes back to page 1.
- The page length (36) is the engine's (`rq.skilllist`). `y` is not in the Lua: read it from the
  `skill-page-prev` row of `rqmod-ctl ui` with the window open.
