local day_cycle = {}
local day = true
local day_length = 60

function day_cycle.everyone_home()
	-- TODO
	print("Everyone is home")
end

function day_cycle.is_day()
	return day
end

function day_cycle.day_length()
	return day_length
end

function day_cycle.start_day()
	day = true
end

function day_cycle.start_night()
	day = false
end

return day_cycle