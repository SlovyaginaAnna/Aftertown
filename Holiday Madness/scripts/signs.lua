local S = {}
local tiles = {{38, 92}, {108, 92}, {38, 67}, {65, 84}, {108, 84}, {108, 80}, {137, 71},
{38, 45}, {45, 45}, {52, 45}, {65, 45}, {82, 45}, {121, 45}, {137, 45}, {116, 52},
{145, 25}, {115, 25}, {115, 18}, {99, 15}, {99, 26}, {99, 36}, {82, 36}, {82, 26}, {82, 15},
 {45, 15}, {31, 2}, {38, 26}, {38, 36}, {52, 62}, {65, 62}, {115, 36}, {38, 74}}
local signs = {} --table with all signs placed on a crossroad
local tile_size = 16
local tiles_count = 32
local signs_num = 13
local sign_types = {'green_brick', 'red_brick', 'green_straight', 'red_straight', 'green_right', 'red_right', 'green_left', 'red_left',
'green_not_right', 'red_not_right', 'green_not_left', 'red_not_left', 'traffic_light'} --all signs types
local quantity = {} --tabel consists of type of the sign, bought number and placed number
local price = {10, 15, 20, 25, 30, 25, 34, 60, 48, 10, 22, 45, 10}


function S.init()
	for i = 1, #tiles do
		table.insert(signs, {0, false, {}, {}})
	end
	for i = 1, #sign_types do
		table.insert(quantity, {sign_types[i], 0, 0})
	end
end

function S.tile_index(event_pos)
	local x = event_pos.x + go.get_position("/camera#camera").x
	local y = event_pos.y + go.get_position("/camera#camera").y
	for i = 1, tiles_count  do
		if x < tiles[i][1] * tile_size + tile_size and x > tiles[i][1] * tile_size - tile_size * 2 and
		y < tiles[i][2] * tile_size + tile_size and y > tiles[i][2] * tile_size - tile_size * 2 then
			return i
		end
	end
	return 0
end

function S.pos(index)
	local x = tiles[index][1] * tile_size - tile_size / 2
	local y = tiles[index][2] * tile_size - tile_size / 2
	return vmath.vector3(x, y, 1)
end

function S.price(type)
	index = 0
	for i = 1, signs_num do
		if type == sign_types[i] then
			index = i
			break
		end
	end
	return price[index]
end

function S.available(currency)
	not_available = {}
	for i = 1, signs_num do
		if price[i] <= currency then
			table.insert(not_available, sign_types[i])
		end
	end
	return not_available
end

function S.allSigns()
	return sign_types
end

function S.buySign(type)
	for i = 1, #quantity do
		if type == quantity[i][1] then
			quantity[i][3] = quantity[i][3] + 1
			break
		end
	end
end

function S.price_by_type(type)
	for i = 1, #sign_types do
		if sign_types[i] == type then
			return price[i]
		end
	end
	return 0
end

function S.get_price_table()
	return price
end

function S.get_sign_by_index(index)
	return signs[index]
end

function S.get_quantity()
	return quantity
end

function S.set_sign(type)
	for i = 1, #quantity do
		if type == quantity[i][1] and quantity[i][2] < quantity[i][3] then
			quantity[i][2] = quantity[i][2] + 1
			return true
		end
	end
	return false
end

function S.change_quantity(type)
	for i = 1, #quantity do
		if type == quantity[i][1] then
			quantity[i][2] = quantity[i][2] - 1
		end
	end
end

return S