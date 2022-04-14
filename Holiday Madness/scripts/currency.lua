local C = {}
local currency = 56

function C.cash()
	return currency
end

function C.change_money(price)
	currency = currency + price
end

return C