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
	orange = {{19/5, 38/5}, {45/5, 33/5}, {75/5, 35/5}}
	red = {{30/5, 32/5}, {55/5, 35/5}, {65/5, 38/5}}
	for i = 1, 3 do
		H.create(c.pos(orange[i]), 0)
	end
	for i = 1, 3 do
		H.create(c.pos(red[i]), 1)
	end		
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