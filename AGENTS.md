# Potential skill pages — author notes

You have this mod’s Lua and `lua_docs.html`. You do not have a decompile. Read `init.lua` before changing the page rules or the agent instructions.

Fill `AI_TEST_INSTRUCTIONS.md` from the Lua, not from memory:

- Button create site: `rq.skilllist.on_buttons`. The ids registered there are `skill-page-prev` and `skill-page-next`.
- `on_page`: `false` greys the arrow (deny sound). A returned page number moves. `on_open` resets to page 1.
- Page length: 36, from the comment at the top of `init.lua` and from `ctx.pages`.
- What greys a button: `on_page` returns `false` when the next page would be &lt; 1 or &gt; `ctx.pages`.

If a button id or handle is not in the Lua, log it once at create time (`on_buttons` already logs `prev` / `next` once) or read it back from `rq.agent.control` / `rqmod-ctl ui`. Do not read it out of the AIN.

`y` is not in the Lua. After the window is open, read `y` from the `skill-page-prev` row in `ui`.

## Template for `AI_TEST_INSTRUCTIONS.md`

```markdown
# <mod name> — agent notes

This file is optional. It is read only because this mod is installed.
If this file is missing, or the ids below are not in `rqmod-ctl ui`, do not assume the controls.

## When the menu exists

<when the buttons are alive, and that hover/press fail after they are gone>

## Control ids

| id | label | role |
| --- | --- | --- |
| <stable pipe id> | <label> | <what a press does> |

## Layout

<page size, y, what sits above and below>

## Page rules

<open page, grey deny, whether a buy stays on the page>

## <case name>

<one concrete character or screen, with skill or item ids that are past page 1>
```
