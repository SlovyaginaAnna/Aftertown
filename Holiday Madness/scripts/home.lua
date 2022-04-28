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