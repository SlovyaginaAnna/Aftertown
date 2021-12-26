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
	index = c.randColAndRow() 
	if index ~= nil then
		H.count = H.count + 1
		position = c.colAndRowToPos(index)
		position.z = 1
		H.create(position, -1)
	end
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