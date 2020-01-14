
-- returns the depth in nodes, calculated from the steps
function enhanced_quarry.calculate_depth_in_nodes(meta)
  local depth_steps = meta:get_int("depth_steps")
  local radius = meta:get_int("radius")

  local offset = radius + 1
  return offset + ( ((radius*2)+1) * depth_steps)
end
