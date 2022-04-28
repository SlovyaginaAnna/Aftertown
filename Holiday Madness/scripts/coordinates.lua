
local C = {}
C.coord	= {}  --таблица, хранящая все клетки 
C.road_built = {} --таблица, хранящая, построена ли на этой клетке дорога (для того, чтобы
-- к одному дому подходила только одна дорога)
C.coordinates_for_signs = {}
C.rows = 19
C.columns = 20
C.cell = 48

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
	-- TODO - remove.
end

function C.setEnableCells()
	-- TODO: remove this option entirely.
end

function C.setWidth(first, second, i, j, width)
	-- TODO - remove.
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
	-- TODO - remove.
	index = road_number - 1
	indexes = {math.floor(index / C.rows) + 1, index % C.rows + 1}
	return C.coord[indexes[1]][indexes[2]].width
end

function C.enableCells(first, second, i, j)
	-- TODO - remove.
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

return C