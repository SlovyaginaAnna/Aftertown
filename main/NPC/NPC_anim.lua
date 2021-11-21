-- Animation related functions for NPC.

-- Get direction hash for animating NPC, which moves on delta vector.
function get_direction(delta)
	local angle = math.deg(math.atan2(delta.y, delta.x))
	if (angle <= 22.5 and angle > -22.5) then
		return hash("Run_right")
	elseif (angle > 22.5 and angle <= 67.5) then
		return hash("Run_up_right")
	elseif (angle > 67.5 and angle <= 112.5) then
		return hash("Run_up")
	elseif (angle > 112.5 and angle <= 157.5) then
		return hash("Run_up_left")
	elseif (angle > 157.5 or angle <= -157.5) then
		return hash("Run_left")
	elseif (angle > -157.5 and angle <= -112.5) then
		return hash("Run_down_left")
	elseif (angle > -112.5 and angle <= -67.5) then
		return hash("Run_down")
	else
		return hash("Run_down_right")
	end
end
