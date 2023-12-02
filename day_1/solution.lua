-- Solution for AoC-23 day 1 in lua

print("===== Solution day-1 =====")

local file = assert(io.open('input.txt', 'r'), 'File not found')

-- solution part 1

local function number_from_string_p1(str)
    local rev = string.reverse(str)
    local i = string.sub(str, 0, string.find(str, "%d"))
    local j = string.sub(rev, 0, string.find(rev, "%d"))

    return tonumber(string.match(i, '%d') .. string.match(j, '%d'))
end

-- solution part 2

local digits = {
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine'
}

local function print_table(t)
    if t == nil then
        print("Table empty")
        return
    end
    for k, v in pairs(t) do
        print(k .. " " .. v.index .. " " .. v.num)
    end
end

local function pattern_matches(str)
    local t = {}

    -- find matching patterns
    for key, pat in pairs(digits) do
        local index = 0
        while true do
            local i = string.find(str, pat, index)
            if i == nil then
                break
            end
            table.insert(t, {index=i, num=key})
            index = i + 1
        end
    end

    if #t == 0 then
        return nil
    end

    return t
end

local function number_matches(str)
    local t = {}

    for num = 1, 9, 1 do
        local index = 0
        while true do
            local i = string.find(str, tostring(num), index)
            if i == nil then
                break
            end
            table.insert(t, {index=i, num=num})
            index = i + 1
        end
    end

    if #t == 0 then
        return nil
    end

    return t
end

local function number_from_string_p2(str)
    local firstDigit, lastDigit = 0, 0

    local patterns = pattern_matches(str)
    local pFirst, pLast = {index=math.huge, num=0}, {index=0, num=0}
    if patterns ~= nil then
        table.sort(patterns, function(a,b) return a.index < b.index end)
        pFirst = patterns[1]
        pLast = patterns[#patterns]
    end

    local numbers = number_matches(str)
    local numFirst, numLast = {index=math.huge, num=0}, {index=0, num=0}
    if numbers ~= nil then
        table.sort(numbers, function(a,b) return a.index < b.index end)
        numFirst = numbers[1]
        numLast = numbers[#numbers]
    end

    if pFirst.index < numFirst.index then
        firstDigit = pFirst.num
    else
        firstDigit = numFirst.num
    end

    if pLast.index > numLast.index then
        lastDigit = pLast.num
    else
        lastDigit = numLast.num
    end

    return tonumber(firstDigit .. lastDigit)
end

local calVal1 = 0
local calVal2 = 0

-- read all lines
for line in file:lines() do
    local num = number_from_string_p1(line)
    local num2 = number_from_string_p2(line)
    calVal1 = calVal1 + num
    calVal2 = calVal2 + num2
end

print("Calibration Value Part 1:", calVal1)
print("Calibration Value Part 2:", calVal2)
