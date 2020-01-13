
local has_technic_mod = minetest.get_modpath("technic")

if has_technic_mod then
  minetest.register_craft({
    recipe = {
      {"technic:quarry", "pipeworks:filter", "technic:composite_plate"},
      {"basic_materials:motor", "technic:machine_casing", "technic:diamond_drill_head"},
      {"default:goldblock", "technic:hv_cable", "technic:quarry"}
    },
    output = "enhanced_quarry:enhanced_quarry",
  })
end

-- TODO: non-technic recipe
