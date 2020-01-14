
function enhanced_quarry.on_receive_fields(pos, _, fields, sender)

  if not sender then
    return
  end

  if minetest.is_protected(pos, sender:get_player_name()) then
    -- not allowed
    return
  end

  local meta = minetest.get_meta(pos)

  if fields.save then
    local max_depth = math.min(100, tonumber(fields.depth or "0"))
    meta:set_int("max_depth", max_depth)
  end

  if fields.toggle then
    local run = meta:get_int("run")

    if run == 1 then
      meta:set_int("run", 0)
    else
      meta:set_int("run", 1)
    end

    meta:set_string("message", "")
    meta:set_int("depth_steps", 0)

    enhanced_quarry.update_formspec(meta)
    enhanced_quarry.update_infotext(meta)
  end

end
