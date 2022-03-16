local c = require "scripts.coordinates"
local S ={}
S.shops	= {}  --таблиа хранящая все магазины
S.count = 0
daytime = 200
nighttime = 100
day_time = true

function S.initShops()
	day()
	local orange = {{28, 58}, {126, 130}}
	local red = {{10, 19}, {116, 61}}
	for i = 1, 2 do
		S.create(c.pos(orange[i]), 0)
		S.create(c.pos(red[i]), 1)
	end
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

day = function()

end

night = function()

end

return S
