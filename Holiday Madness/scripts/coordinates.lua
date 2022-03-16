
local C = {}
C.coord	= {}  --таблица, хранящая все клетки 
C.road_built = {} --таблица, хранящая, построена ли на этой клетке дорога (для того, чтобы
				  -- к одному дому подходила только одна дорога)
C.rows = 18
C.columns = 19
C.cell = 70

function C.initCoord()
	C.coord	= {}
	local position = vmath.vector3()
	for i = 0, C.columns - 1 do
		position.x = i * C.cell + C.cell / 2
		tab = {}
		for j = 0, C.rows - 1 do
			position.y = j * C.cell + C.cell / 2
			C.generate(position, tab)
		end
		table.insert(C.coord, tab)
	end
	C.setEnableCells()
	C.setWidths()
end

function C.pos(coord)
	return vmath.vector3(coord[1] * C.cell, coord[2] * C.cell, 0)
end

function C.generate(position, tab)	
	--это структура клетки. 
	local cStruct = {
		isEmpty = true,
		hasSign = false,
		center 	= position,
		width = 1,
		handle = nil,
	}
	table.insert(tab, cStruct)
	table.insert(C.road_built, false)
end

function C.setWidths()
	C.setWidth(1, 14, 5, 0, 2)
	C.setWidth(1, 14, 6, 0, 2)
	C.setWidth(10, 14, 9, 0, 2)
	C.setWidth(10, 14, 10, 0, 2)
	C.setWidth(10, 14, 11, 0, 2)
end

function C.setEnableCells()
	-- TODO: remove this option entirely.
end

function C.setWidth(first, second, i, j, width)
	if i == 0 then
		for k = first, second do
			C.coord[k][j].width = width
		end
	else 
		for k = first, second do
			C.coord[i][k].width = width
		end
	end
end

function C.getWidth(road_number)
	index = road_number - 1
	indexes = {math.floor(index / C.rows) + 1, index % C.rows + 1}
	return C.coord[indexes[1]][indexes[2]].width
end

function C.enableCells(first, second, i, j)
	if i == 0 then
		for k = first, second do
			C.coord[k][j].isEmpty = false
		end
	else 
		for k = first, second do
			C.coord[i][k].isEmpty = false
		end
	end
end

function C.isBlocked(indexes)
	if indexes[1] > C.columns or indexes[2] > C.rows then
		return true
	else
		return (not C.isEmpty(indexes) and C.coord[indexes[1]][indexes[2]].handle == nil)
	end
end

function C.isEmpty(indexes)
	if indexes[1] > C.columns or indexes[2] > C.rows then
		return false
	else
		empty = C.coord[indexes[1]][indexes[2]].isEmpty
		return empty
	end
end

function C.isEmptyIndex(index)
	index = index - 1
	indexes = {math.floor(index / C.rows) + 1, index % C.rows + 1}
	empty = C.coord[indexes[1]][indexes[2]].isEmpty
	return empty
end

function C.setSmth(position, handle)
	index = C.colAndRow(position)
end

function C.setSign(position, handle)
	index = C.colAndRow(position)
	C.coord[index[1]][index[2]].handle = handle
	C.coord[index[1]][index[2]].hasSign = true
end

function C.getSign(position)
	index = C.colAndRow(position)
	if C.coord[index[1]][index[2]].hasSign then
		return C.coord[index[1]][index[2]].handle
	else
		return nil
	end
end

function C.suitable(indexes)
	c = indexes[1]
	r = indexes[2]
	suit = true
	upper = r % (C.rows) == 0
	lower = r % (C.rows) == 1
	right = c % (C.columns) == 1
	left = c % (C.columns) == 0
	if not upper and (C.coord[c][r + 1].isEmpty) then
		return suit
	elseif not lower and (C.coord[c][r - 1].isEmpty) then
		return suit
	elseif not left and (C.coord[c - 1][r].isEmpty) then
		return suit
	elseif not right and (C.coord[c + 1][r].isEmpty) then
		return suit
	elseif not upper and not left and (C.coord[c - 1][r + 1].isEmpty) then
		return suit
	elseif not upper and not right and (C.coord[c + 1][r + 1].isEmpty) then
		return suit
	elseif not lower and not left and (C.coord[c - 1][r - 1].isEmpty) then
		return suit
	elseif not lower and not right and (C.coord[c + 1][r - 1].isEmpty) then
		return suit
	else
		return not suit
	end
end

function C.index(position)
	col = (position.x - position.x % C.cell + C.cell) / C.cell
	r =  (position.y - position.y % C.cell + C.cell) / C.cell
	return (col - 1) * C.rows + r % (C.rows + 1)
end

function C.colAndRow(position)
	col = (position.x - position.x % C.cell + C.cell) / C.cell
	r =  (position.y - position.y % C.cell + C.cell) / C.cell
	return {col, r}
end

function C.colAndRowToPos(index) 
	position = vmath.vector3(0, 0, 0)
	position.x = (index[1] - 1) * C.cell + C.cell / 2
	position.y = (index[2] - 1) * C.cell + C.cell / 2
	return position
end

function C.randColAndRow()
	count = 0
	repeat
		col = math.random(1, C.columns)
		r = math.random(1, C.rows)
		count = count + 1
	until(C.isEmpty({col, r}) and C.suitable({col, r}) or count == 20) 
	if count == 20 then
		return nil
	else 
		return {col, r}
	end
end
return C