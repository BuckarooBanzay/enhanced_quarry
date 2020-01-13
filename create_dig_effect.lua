
function enhanced_quarry.create_dig_effect(dig_pos, dig_pos1, dig_pos2, dig_direction)
  local inv_pos = {x=-1, y=-1, z=-1}
  local direction = vector.multiply(dig_direction, inv_pos)

  local velocity = vector.multiply(direction, {x=1, y=1, z=1})
  local acceleration = vector.multiply(direction, {x=1, y=1, z=1})

  minetest.add_particlespawner({
    amount = 30,
    time = 1,
    minpos = dig_pos1,
    maxpos = dig_pos2,
    minvel = velocity,
    maxvel = velocity,
    minacc = acceleration,
    maxacc = acceleration,
    minexptime = 4,
    maxexptime = 4,
    minsize = 1,
    maxsize = 2,
    texture = "enhanced_quarry_spark.png",
    glow = 5,
  })

  minetest.sound_play("default_dug_node." .. math.random(1,2), {
		pos = dig_pos,
		max_hear_distance = 25,
		gain = 1,
	})

end
