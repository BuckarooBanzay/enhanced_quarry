
function enhanced_quarry.on_receive_fields(pos, _, fields, sender)

  if not sender then
    return
  end

  if minetest.is_protected(pos, sender:get_player_name()) then
    -- not allowed
    return
  end

  if fields.test then
    enhanced_quarry.execute_dig(pos)
  end

end
