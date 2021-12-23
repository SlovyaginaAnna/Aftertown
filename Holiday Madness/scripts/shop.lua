local c = require "scripts.coordinates"
local S ={}
S.shops	= {}  --таблиа хранящая все магазины
S.count = 0

function S.initShops()
	S.shops = {} 
	position = c.indToPos(c.randIndex())
	position.z = 1
	S.create(position, 0)
	position = c.indToPos(c.randIndex())
	position.z = 1
	S.create(position, 1)
	S.count = 2
end

function S.addShop()
	index = c.randIndex() 
	if index ~= -1 then
		S.count = S.count + 1
		position = c.indToPos(index)
		position.z = 1
		S.create(position, -1)
	end
end

function S.create(position, varient)
	if varient == -1 then
		varient = math.random(0, 1)
	end
	if varient == 0 then 
		obj = factory.create("/shopFactory#factory", position, nil, {}, 1.0)
	else 
		obj = factory.create("/shop1Factory#factory", position, nil, {}, 1.0)
	end
	local hStruct = {
		pos 	= position,
		url 	= obj, 
	}
	c.setSmth(position, obj)
	table.insert(S.shops, hStruct)
	msg.post("/go#main", "check_shop_timer")
end

function S.getShop()
	return S.shops[1]
end

return S