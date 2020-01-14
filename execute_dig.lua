
local air_id = minetest.get_content_id("air")


function enhanced_quarry.execute_dig(pos)
  local node = minetest.get_node(pos)

  if node and node.name == "ignore" then
    -- something is off :/
    return
  end

  local meta = minetest.get_meta(pos)
  local owner = meta:get_string("owner")

  -- assemble coords
  local face_dir = minetest.facedir_to_dir(node.param2)

  local radius = meta:get_int("radius")
  local radius_pos = {x=radius, y=radius, z=radius}

  local depth = meta:get_int("depth")
  local max_depth = meta:get_int("max_depth")

  if depth > max_depth then
    -- target depth reached
    meta:set_string("message", "Target depth reached")
    meta:set_int("run", 0)
    return
  end

  local position_offset = vector.multiply(face_dir, {x=depth, y=depth, z=depth})
  local plane_subtract = vector.multiply(face_dir, radius_pos)

  local dig_pos = vector.add(pos, position_offset)

  -- this should now be a flat plane
  local dig_pos1 = vector.add( vector.subtract(dig_pos, radius_pos), plane_subtract )
  local dig_pos2 = vector.subtract( vector.add(dig_pos, radius_pos), plane_subtract )

  -- check protection
  local protected = enhanced_quarry.is_area_protected(dig_pos1, dig_pos2, owner)

  if protected then
    meta:set_string("message", "Digging protected nodes around position: " .. minetest.pos_to_string(dig_pos))
    meta:set_int("run", 0)
    return
  end

  -- node_name -> count
  local digged_node_map = {}

  -- collect drops with vmanip
  local manip = minetest.get_voxel_manip()
  local e1, e2 = manip:read_from_map(dig_pos1, dig_pos2)
  local vm_area = VoxelArea:new({MinEdge=e1, MaxEdge=e2})
  local data = manip:get_data()
  local param1_data = manip:get_light_data()
	local param2_data = manip:get_param2_data()

  for z=dig_pos1.z, dig_pos2.z do
	for y=dig_pos1.y, dig_pos2.y do
	for x=dig_pos1.x, dig_pos2.x do
    local index = vm_area:index(x, y, z)
    local id = data[index]

    local success = enhanced_quarry.collect_digged_items(id, digged_node_map)

    if not success then
      -- artifical/complex node encountered, abort
      meta:set_string("message", "Digging obstructed around position: " .. minetest.pos_to_string(dig_pos))
      meta:set_int("run", 0)
      return
    end

    data[index] = air_id
    param1_data[index] = 0
    param2_data[index] = 0
  end
  end
  end

  -- clear digged area
  manip:set_data(data)
	manip:set_light_data(param1_data)
	manip:set_param2_data(param2_data)
	manip:write_to_map()
	manip:update_map()

  -- add effects
  enhanced_quarry.create_dig_effect(depth, dig_pos, dig_pos1, dig_pos2, face_dir)

  -- shift to next dig depth
  meta:set_int("depth", depth + 1)

  -- add to inventory
  local inv = meta:get_inventory()

  for name, count in pairs(digged_node_map) do
    local stack = ItemStack(name)
    stack:set_count(count)

    if inv:room_for_item("main", stack) then
      inv:add_item("main", stack)
    end
  end

end
