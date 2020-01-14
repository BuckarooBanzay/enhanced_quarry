

function enhanced_quarry.update_infotext(meta)
	local infotext = "Enhanced quarry "

	local run = meta:get_int("run")
	if run == 1 then
		local depth = enhanced_quarry.calculate_depth_in_nodes(meta)
		infotext = infotext + "(digging @ " .. depth .. "m)"
	else
		infotext = infotext + "(idle)"
	end

	local message = meta:get_string("message")
	if message ~= "" then
		infotext = message
	end

	meta:set_string("infotext", infotext)
end
