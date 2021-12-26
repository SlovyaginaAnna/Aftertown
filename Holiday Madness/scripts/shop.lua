local c = require "scripts.coordinates"
local S ={}
S.shops	= {}  --таблиа хранящая все магазины
S.count = 0
daytime = 60
nighttime = 20

function S.initShops()
	S.shops = {} 
	for i = 0, 1 do
		indexes = nil
		while indexes == nil do
			indexes = c.randColAndRow()
		end
		position = c.colAndRowToPos(indexes)
		position.z = 1
		S.create(position, i)
	end
	S.count = 2
	day()
end

function S.addShop()
	index = c.randColAndRow() 
	if index ~= nil then
		S.count = S.count + 1
		position = c.colAndRowToPos(index)
		position.z = 1
		S.create(position, -1)
	end
end

function S.create(position, varient)
	if varient == -1 then
		varient = math.random(0, 1)
	end
	position.z = 0.7
	if varient == 0 then 
		obj = factory.create("/shopFactory#factory", position, nil, {}, 1.0)
	else 
		obj = factory.create("/shop1Factory#factory", position, nil, {}, 1.0)
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
	msg.post("/navigator", "day")
	timer.delay(daytime, false, night)
end

night = function()
	msg.post("/navigator", "night")
	for i = 1, #S.shops do
		msg.post(S.shops[i].url, "night")
	end
	timer.delay(nighttime, false, day)
end

return S