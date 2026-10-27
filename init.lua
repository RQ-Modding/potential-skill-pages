-- Potential skill pages. 36 skills per page on the Potential Skills grid.
-- C keeps the buy list and draws Previous Page / Next Page.
-- Lua owns the page index and whether a click moves.

rq.log("potential-skill-pages: loading")

if not rq.skilllist or not rq.skilllist.install then
  error("potential-skill-pages: rq.skilllist missing (engine too old)")
end

if not rq.skilllist.install() then
  error("potential-skill-pages: install failed")
end

rq.skilllist.on_open(function()
  rq.skilllist.set_page(1)
end)

rq.skilllist.on_page(function(ctx)
  if ctx.dir == 0 then return ctx.page end
  local nextp = ctx.page + ctx.dir
  if nextp < 1 or nextp > ctx.pages then return false end
  return nextp
end)

rq.log("potential-skill-pages: page 1 on open; deny past either end")
