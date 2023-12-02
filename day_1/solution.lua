-- Solution for AoC-23 day 1 in lua

print("===== Solution day-1 =====")

local file = assert(io.open('input.txt', 'r'), 'File not found')
local calVal = 0

local function number_from_string(str)
    local rev = string.reverse(str)
    local i = string.sub(str, 0, string.find(str, "%d"))
    local j = string.sub(rev, 0, string.find(rev, "%d"))


    return tonumber(string.match(i, '%d') .. string.match(j, '%d'))
end

-- read all lines
for line in file:lines() do
    local num = number_from_string(line)
    calVal = calVal + num
end

print("Calibration Value:", calVal)
