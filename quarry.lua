local has_technic_mod = minetest.get_modpath("technic")
local has_pipeworks_mod = minetest.get_modpath("pipeworks")

local tube_entry = ""
local cable_entry = ""

if has_pipeworks_mod then
	tube_entry = "^pipeworks_tube_connection_metallic.png"
end

if has_technic_mod then
	cable_entry = "^technic_cable_connection_overlay.png"
end

minetest.register_node("enhanced_quarry:enhanced_quarry", {
	description = "Enhanced Quarry",
	tiles = {
		"default_gold_block.png"..tube_entry,
		"default_gold_block.png"..cable_entry,
		"default_gold_block.png"..cable_entry,
		"default_gold_block.png"..cable_entry,
		"default_gold_block.png^default_tool_diamondpick.png",
		"default_gold_block.png"..cable_entry
	},
	paramtype2 = "facedir",
	groups = {
    cracky=2,
    tubedevice=1,
    technic_machine=1,
    technic_hv=1
  },

  connects_to = {"group:technic_hv_cable"},
	connect_sides = {"bottom", "front", "left", "right"},

	tube = {
		connect_sides = {top = 1},
		priority = 10
	},

  after_place_node = function(pos, placer)
    local meta = minetest.get_meta(pos)
    meta:set_string("owner", placer:get_player_name() or "")
  end,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_int("version", 1)

		-- energy storage
		meta:set_int("powerstorage", 0)
		meta:set_int("max_powerstorage", 150000)
		meta:set_int("power_requirement", 25000) -- power requirement if charging

		-- power usage
		meta:set_int("HV_EU_input", 0)
		meta:set_int("HV_EU_demand", 0) -- current demand

		-- state
		meta:set_int("run", 0)
		meta:set_int("radius", 1) -- nodes around dig-point
		meta:set_int("max_depth", 100) -- in nodes away from quarry
		meta:set_int("depth", 1) -- in nodes

    -- inventories
    local inv = meta:get_inventory()
    inv:set_size("main", 8*4)

		enhanced_quarry.update_formspec(meta, pos)
		enhanced_quarry.update_infotext(meta, pos)
	end,

  on_receive_fields = enhanced_quarry.on_receive_fields,
	technic_run = enhanced_quarry.technic_run,

  can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		local name = player:get_player_name()

		return inv:is_empty("main") and not minetest.is_protected(pos, name)
	end,

})
