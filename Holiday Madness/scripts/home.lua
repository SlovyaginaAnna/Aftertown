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
	orange = {{19, 38}, {45, 33}, {75, 35}, {145, 11}, {134, 25}, {117, 104}, {107, 104}, {30, 121}, {46, 120}, {46, 108}}
	red = {{30, 32}, {55, 35}, {65, 38}, {134, 11}, {122, 19}, {112, 113}, {103, 114}, {128, 103}, {30, 113}, {30, 106}, {46, 113}}
	for i = 1, 10 do
		H.create(c.pos(orange[i]), 0)
	end
	for i = 1, 11 do
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