-- Parse input file
local file = io.open("historian-hysteria-input.txt")

for line in file:lines() do
    print(line) -- process each line
end

if not file then error("Could not open file") end

-- Variable from problem
local location_id = 0

