
function enhanced_quarry.technic_run(pos)
  local meta = minetest.get_meta(pos)

  local eu_input = meta:get_int("HV_EU_input")
  local power_requirement = meta:get_int("power_requirement")
  local powerstorage = meta:get_int("powerstorage")
  local max_powerstorage = meta:get_int("max_powerstorage")

  if powerstorage < max_powerstorage then
    -- charge
    meta:set_int("HV_EU_demand", power_requirement)
    powerstorage = powerstorage + eu_input
    meta:set_int("powerstorage", math.min(powerstorage, max_powerstorage))
  else
    -- charged
    meta:set_int("HV_EU_demand", 0)
  end

  local run = meta:get_int("run") == 1

  if powerstorage >= max_powerstorage and run then
    -- enough power, dig
    enhanced_quarry.execute_dig(pos)
    meta:set_int("powerstorage", 0)
  end


  enhanced_quarry.update_infotext(meta, pos)
  enhanced_quarry.update_formspec(meta, pos)
end
