local S = {}
local tiles = {{31, 125}, {38, 125}, {65, 125}, {38, 115}, {65, 115}, {28, 92},
{38, 92}, {65, 92}, {82, 92}, {96, 92}, {108, 92}, {118, 92}, {137, 92},
{96, 104}, {96, 113}, {38, 67}, {52, 67}, {65, 78}, {65, 84}, {82, 84}, {108, 84},
{108, 80}, {118, 80}, {137, 71}, {38, 45}, {45, 45}, {52, 45}, {65, 45}, {82, 45},
{121, 45}, {137, 45}, {116, 52}, {145, 25}, {115, 25}, {115, 18}, {99, 15},{99, 26},
{99, 36}, {82, 36}, {82, 26}, {82, 15}, {45, 15}, {31, 2}, {38, 26}, {38, 36}}
local tile_size = 16
local tiles_count = 45
local sign_types = {'green_brick', 'red_brick', 'green_straight', 'right_straight', 'green_right', 'red_right', 'green_left', 'right_left',
	'green_not_right', 'red_not_right', 'green_not_left', 'red_not_left', 'traffic_light'}

function S.pos(event_pos)
	local x = event_pos.x + go.get_position("/camera#camera").x
	local y = event_pos.y + go.get_position("/camera#camera").y
	for i = 1, tiles_count  do
		if x < tiles[i][1] * tile_size + tile_size and x > tiles[i][1] * tile_size - tile_size * 2 and
		y < tiles[i][2] * tile_size + tile_size and y > tiles[i][2] * tile_size - tile_size * 2 then
			return vmath.vector3(tiles[i][1] * tile_size - tile_size / 2, tiles[i][2] * tile_size - tile_size / 2, 1)
		end
	end
	return nil
end

return S