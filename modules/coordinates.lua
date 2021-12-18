local C ={}
C.coord	= {}  --таблиа хранящая все клетки 

--======================================
function C.initCoord()
	C.coord	= {}
	for i = 0, 19 do
		for j = 0, 10 do
			local position = vmath.vector3()
			position.x = i * 96 + 48
			position.y = j * 96 + 48
			C.generate(position)
		end
	end
end

function C.generate(position)	
	--это структура клетки. 
	local cStruct = {
		isEmpty = true,
		center 	= position
	}
	table.insert(C.coord, cStruct)
end

function C.isEmpty(position)
	for i =1, #C.coord,1 do
		if C.coord[i].center.x == (position.x - position.x % 96) + 48 and
		C.coord[i].center.y == (position.x - position.x % 96) + 48 then
			return C.coord[i].isEmpty
		end
	end
	return true	
end

function C.setSmth(position)
	for i =1, #C.coord do
		if C.coord[i].center.x == (position.x - position.x % 96) + 48 and
		C.coord[i].center.y == (position.x - position.x % 96) + 48 then
			C.coord[i].isEmpty = false
		end
	end
end
return C