local c = require "scripts.coordinates"
local day_cycle = require "scripts.day_cycle"
local H ={}
H.homes	= {}  --таблиа хранящая все дома
H.count = 0
local cars_home = 0
local all_cars = {}

function H.start()
	local cars_home = 0
	for e, home in pairs(H.homes) do
		msg.post(home.url, 'start')
	end
end

function H.sendCar(car)
	cars_home = cars_home - 1
	table.insert(all_cars, car)
end

function H.clearCars()
	for e, car in pairs(all_cars) do
		msg.post(car, 'delete')
	end
	all_cars = {}
end

function H.returnCar()
	cars_home = cars_home + 1
	if cars_home == 0 then
		day_cycle.everyone_home()
	end
end

function H.initHomes()
	H.homes = {}
	H.count = 0
	H.addHome()
end

function H.addHome()
	H.create(vmath.vector3(730.0, 567.3, 0), 0)
	H.create(vmath.vector3(295.1, 568.6, 0), 0)
	
	H.create(vmath.vector3(871.6, 569.8, 0), 1)
	H.create(vmath.vector3(465.5, 568.6, 0), 1)
end

function H.create(position, varient)
	position.z = 0.7
	if varient == 0 then 
		obj = factory.create("/orangeHomeFactory#factory", position, nil, {number = c.index(position)}, 1.0)
	else 
		obj = factory.create("/redHomeFactory#factory", position, nil, {number = c.index(position)}, 1.0)
	end
	local hStruct = {
		pos 	= position,
		url 	= obj, 
	}
	c.setSmth(position, obj)
	table.insert(H.homes, hStruct)
end

return H