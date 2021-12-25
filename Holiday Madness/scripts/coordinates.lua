--<<<<<<< HEAD
local C = {}
C.coord	= {}  --таблица, хранящая все клетки 
C.road_width = {} --таблица, хранящая ширину дороги, которую можно здесь построить
C.road_built = {} --таблица, хранящая, построена ли на этой клетке дорога (для того, чтобы
				  -- к одному дому подходила только одна дорога)
C.rows = 17
C.columns = 18
C.cell = 48
-->>>>>>> 9ce0a27718e49433bbd5ff020db48a05c53c96e6

--======================================
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
end

function C.generate(position, tab)	
	--это структура клетки. 
	local cStruct = {
		isEmpty = true,
		center 	= position,
		handle = nil
	}
	table.insert(tab, cStruct)
	table.insert(C.road_width, 1)
	table.insert(C.road_built, false)
end

function C.isEmpty(indexes)
	empty = C.coord[indexes[1]][indexes[2]].isEmpty
	return empty
end

function C.setSmth(position, handle)
	index = C.index(position)
	C.coord[index[1]][index[2]].isEmpty = false
	C.coord[index[1]][index[2]].handle = handle
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
	return {col, r}
end

function C.indToPos(index) 
	position = vmath.vector3(0, 0, 0)
	position.x = (index[1] - 1) * C.cell + C.cell / 2
	position.y = (index[2] - 1) * C.cell + C.cell / 2
	return position
end

function C.randIndex()
	count = 0
	repeat
		col = math.random(1, C.columns)
		r = math.random(1, C.rows)
		count = count + 1
	until(C.isEmpty({col, r}) and C.suitable({col, r}) or count == 20) 
	if count == 20 then
		return {}
	else 
		return {col, r}
	end
end
return C