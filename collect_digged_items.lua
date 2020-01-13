
-- node_id -> drops
local map = {}

minetest.register_on_mods_loaded(function()
  for name, nodedef in pairs(minetest.registered_nodes) do
    if type(nodedef.drop) == "string" and
      nodedef.drop ~= "" and
      not nodedef.can_dig then

      -- simple node
      local id = minetest.get_content_id(name)
      map[id] = nodedef.drop
    end
	end
end)

function enhanced_quarry.collect_digged_items(id, digged_node_map)
  local drops = map[id]

  if drops then
    local drops_stack = ItemStack(drops)
    local name = drops_stack:get_name()
    digged_node_map[name] = (digged_node_map[name] or 0) + drops_stack:get_count()

    return true
  end

  return false
end
