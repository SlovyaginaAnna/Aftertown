local c = require "scripts.coordinates"
local S ={}
S.shops	= {}  --таблиа хранящая все магазины
S.count = 0

function S.initShops()
	S.create(vmath.vector3(146, 309, 0), 0)
	S.create(vmath.vector3(1849.47, 918.14, 0), 0)
	S.create(vmath.vector3(450.5, 872, 0), 1)
	S.create(vmath.vector3(1511.43, 1549.04, 0), 1)
	
end

function S.create(position, varient)
	position.z = 0.7
	if varient == 0 then 
		obj = factory.create("/orangeShopFactory#factory", position, nil, {}, 1.0)
	else 
		obj = factory.create("/redShopFactory#factory", position, nil, {}, 1.0)
	end
	local hStruct = {
		pos 	= position,
		url 	= obj, 
		color   = varient,
	}
	c.setSmth(position, obj)
	table.insert(S.shops, hStruct)
end

return S
