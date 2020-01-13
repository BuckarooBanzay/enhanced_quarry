
-- node_id -> drops
local map = {}

-- collect node drops from node_id's
minetest.register_on_mods_loaded(function()
  for name, nodedef in pairs(minetest.registered_nodes) do
    local simple_drop = not nodedef.drop or (type(nodedef.drop) == "string" and nodedef.drop ~= "")
    local has_custom_drop_function = nodedef.can_dig

    if simple_drop and not has_custom_drop_function then
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

    -- everything ok
    return true
  end

  -- non-diggable node encountered
  return false
end
