local c = require "coordinates"
local H ={}
H.homes	= {}  --таблиа хранящая все дома

function H.initHomes()
	H.homes = {}
end

function H.addHome()	
	local position = vmath.vector3()
	repeat
		position.x = math.random(0, 19) * 96 + 48
		position.y = math.random(0, 10) * 96 + 48
	until(c.isEmpty(position)) 
	print(position)
	local hStruct = {
		pos 	= position,
		handle 	= factory.create("/homeFactory#homeFactory", position), 
		print(handle)
	}
	table.insert(H.homes, hStruct)
	c.setSmth(position)
	print(c.isEmpty(position))
end
return H