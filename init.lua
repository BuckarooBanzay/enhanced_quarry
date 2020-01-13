
enhanced_quarry = {
	config = {},
}

local MP = minetest.get_modpath("enhanced_quarry")

dofile(MP.."/is_area_protected.lua")
dofile(MP.."/collect_digged_items.lua")
dofile(MP.."/formspec.lua")
dofile(MP.."/on_receive_fields.lua")
dofile(MP.."/quarry.lua")
dofile(MP.."/execute_dig.lua")
dofile(MP.."/crafts.lua")

print("[OK] Enhanced quarry")
