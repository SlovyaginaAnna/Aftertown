local c = require "scripts.coordinates"
local H ={}
H.homes	= {}  --таблиа хранящая все дома
H.count = 0

function H.initHomes()
	H.homes = {}
	H.count = 0
	H.addHome()
end

function H.addHome()
	H.create(c.colAndRowToPos({17, 2}), 0)
	H.create(c.colAndRowToPos({18, 2}), 1)
	H.create(c.colAndRowToPos({16, 3}), 0)
	H.create(c.colAndRowToPos({18, 4}), 1)
	H.create(c.colAndRowToPos({19, 4}), 1)
	H.create(c.colAndRowToPos({18, 6}), 0)
	H.create(c.colAndRowToPos({18, 7}), 0)
	H.create(c.colAndRowToPos({18, 8}), 1)
	H.create(c.colAndRowToPos({16, 6}), 0)
	H.create(c.colAndRowToPos({16, 7}), 1)
	H.create(c.colAndRowToPos({16, 8}), 0)
	H.create(c.colAndRowToPos({17, 15}), 0)
	H.create(c.colAndRowToPos({16, 15}), 1)
	H.create(c.colAndRowToPos({15, 15}), 0)
	H.create(c.colAndRowToPos({14, 15}), 0)
	H.create(c.colAndRowToPos({14, 17}), 1)
	H.create(c.colAndRowToPos({13, 17}), 0)
	
				
end

function H.create(position, varient)
	if varient == -1 then
		varient = math.random(0, 1)
	end
	position.z = 0.7
	if varient == 0 then 
		obj = factory.create("/homeFactory#factory", position, nil, {number = c.index(position)}, 1.0)
	else 
		obj = factory.create("/home1Factory#factory", position, nil, {number = c.index(position)}, 1.0)
	end
	local hStruct = {
		pos 	= position,
		url 	= obj, 
	}
	c.setSmth(position, obj)
	table.insert(H.homes, hStruct)
end

return H