

function enhanced_quarry.update_formspec(meta)
	local formspec =
		"size[8,10;]" ..

		"button_exit[0,0;2,1;test;Test]" ..

		"list[context;main;0,1;8,4;]" ..
		"list[current_player;main;0,5;8,4;]" ..

		-- listring stuff
		"listring[]"

	meta:set_string("formspec", formspec)
end
