local day_cycle = {}
local day = true
local training = true
local day_length = 60
local night_length = 20
local already_home = false

function day_cycle.everyone_home()
	if already_home == false and not day and not training then
		already_home = true
	end
	print("Everyone is home")
end

function day_cycle.is_day()
	return day
end

function day_cycle.night_lenght()
	return night_length
end

function day_cycle.day_length()
	return day_length
end

function day_cycle.start_day()
	day = true
	already_home = false
end

function day_cycle.start_night()
	day = false
end

function day_cycle.end_training()
	training = false
end

return day_cycle