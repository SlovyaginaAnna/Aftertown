local C = {}
C.coord	= {}  --таблица, хранящая все клетки 
C.road_width = {} --таблица, хранящая ширину дороги, которую можно здесь построить
C.road_built = {} --таблица, хранящая, построена ли на этой клетке дорога (для того, чтобы
				  -- к одному дому подходила только одна дорога)
C.rows = 11
C.columns = 20
C.cell = 96

--======================================
function C.initCoord()
	C.coord	= {}
	local position = vmath.vector3()
	for i = 0, C.columns - 1 do
		position.x = i * C.cell + C.cell / 2
		for j = 0, C.rows - 1 do
			position.y = j * C.cell + C.cell / 2
			C.generate(position)
		end
	end
end

function C.generate(position)	
	--это структура клетки. 
	local cStruct = {
		isEmpty = true,
		center 	= position,
		handle = nil
	}
	table.insert(C.coord, cStruct)
	table.insert(C.road_width, 1)
	table.insert(C.road_built, false)
end

function C.isEmpty(index)
	empty = C.coord[index].isEmpty
	return empty
end

function C.setSmth(position, handle)
	index = C.index(position)
	C.coord[index].isEmpty = false
	C.coord[index].handle = handle
end

function C.suitable(index)
	suit = true
	upper = index % (C.rows) == 0
	lower = index % (C.rows) == 1
	right = index + C.rows > C.rows * C.columns
	left = index - C.rows < 1
	if not upper and (C.coord[index + 1].isEmpty) then
		return suit
	elseif not lower and (C.coord[index - 1].isEmpty) then
		return suit
	elseif not left and (C.coord[index - C.rows].isEmpty) then
		return suit
	elseif not right and (C.coord[index + C.rows].isEmpty) then
		return suit
	elseif not upper and not left and (C.coord[index - C.rows + 1].isEmpty) then
		return suit
	elseif not upper and not right and (C.coord[index + C.rows + 1].isEmpty) then
		return suit
	elseif not lower and not left and (C.coord[index - C.rows - 1].isEmpty) then
		return suit
	elseif not lower and not right and (C.coord[index + C.rows - 1].isEmpty) then
		return suit
	else
		return not suit
	end
end

function C.index(position)
	col = (position.x - position.x % C.cell + C.cell) / C.cell
	r =  (position.y - position.y % C.cell + C.cell) / C.cell
	index = (col - 1) * C.rows + r % (C.rows + 1)
	return index
end

function C.indToPos(index) 
	r = index % C.rows
	if r == 0 then
		r = C.rows
	end
	y = (r - 1) * C.cell + C.cell / 2
	c = (index - r) / C.rows
	x = c * C.cell + C.cell / 2
	position = vmath.vector3(x, y, 0)
	return position
end

function C.randIndex()
	count = 0
	repeat
		index = math.random(1, C.columns * C.rows)
		count = count + 1
	until(C.isEmpty(index) and C.suitable(index) or count == 20) 
	if count == 20 then
		return -1
	else 
		return index
	end
end
return C