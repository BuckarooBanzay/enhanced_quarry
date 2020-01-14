

function enhanced_quarry.update_formspec(meta)

	local depth = meta:get_int("depth")
	local message = meta:get_string("message")
	local powerstorage = meta:get_int("powerstorage")
	local max_depth = meta:get_int("max_depth")

	local run = meta:get_int("run")
	local state = "Idle"
	if run == 1 then
		state = "Digging"
	end

	local formspec =
		"size[8,11;]" ..

		"label[0,0;State: " .. state .. "]" ..
		"label[2,0;Depth: " .. depth .. "]" ..
		"label[4,0;Powerstorage: " .. powerstorage .. " EU]" ..
		"label[6,0;Message: " .. message .. "]" ..

		"button[0,1;2,1;toggle;On/Off]" ..
		"field[4,1;2,1;depth;Max depth;" .. max_depth .. "]" ..
		"button_exit[0,6;2,1;save;Save]" ..

		"list[context;main;0,2;8,4;]" ..
		"list[current_player;main;0,6.5;8,4;]" ..

		-- listring stuff
		"listring[]"

	meta:set_string("formspec", formspec)
end
