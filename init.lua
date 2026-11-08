-- Potential skill pages. 36 skills per page on the Potential Skills grid.
-- C keeps the buy list (144 rows) and cuts each page's 36. Lua owns the page,
-- and Previous Page / Next Page are rq.gamebutton entries on the skill window (loader 2.17.0).

rq.log("potential-skill-pages: loading")

if not rq.skilllist or not rq.skilllist.install or not rq.gamebutton then
  error("potential-skill-pages: rq.skilllist or rq.gamebutton missing (engine too old)")
end

if not rq.skilllist.install({ buttons = false }) then
  error("potential-skill-pages: install failed")
end

rq.skilllist.on_open(function()
  rq.skilllist.set_page(1)
end)

-- The page next to this one, or nil past either end.
local function step(dir)
  local p = rq.skilllist.page() + dir
  if p < 1 or p > rq.skilllist.page_count() then return nil end
  return p
end

rq.skilllist.on_page(function(ctx)
  if ctx.dir == 0 then return ctx.page end
  return step(ctx.dir) or false
end)

local function tip()
  return string.format("Page %d of %d", rq.skilllist.page(), rq.skilllist.page_count())
end

local function go(dir)
  local p = step(dir)
  if not p then return end
  rq.skilllist.set_page(p)
  rq.skilllist.refresh()
end

local prev, next
prev = rq.gamebutton.add({
  group = "skill-window",
  id = "prev",
  label = "Previous Page",
  enabled = function()
    prev.set({ tip = tip() })
    return step(-1) ~= nil
  end,
  on_click = function() go(-1) end,
})
next = rq.gamebutton.add({
  group = "skill-window",
  id = "next",
  label = "Next Page",
  enabled = function()
    next.set({ tip = tip() })
    return step(1) ~= nil
  end,
  on_click = function() go(1) end,
})

rq.log("potential-skill-pages: page 1 on open; Previous / Next on the skill window")
