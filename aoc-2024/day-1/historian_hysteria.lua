local location_id = 0 -- Location ID variable used to calculate distance
local left_list = {}
local right_list = {}

function parse_file(path)
    local file = io.open(path, "r") -- Parse input file

    if not file then error("Could not open file") end -- Print error message if file couldn't be parsed

    -- Read the file line by line
    for line in file:lines() do
        -- Match two numbers separated by whitespace
        local num1, num2 = line:match("(%d+)%s+(%d+)")
        if num1 and num2 then
            -- Convert the numbers to integers and store them
            table.insert(left_list, tonumber(num1))
            table.insert(right_list, tonumber(num2))
        end
    end

    file:close() -- IMPORTANT! Close file after processing it

    -- Print the parsed columns
    print("Column 1:")
    for _, value in ipairs(left_list) do print(value) end

    print("Column 2:")
    for _, value in ipairs(right_list) do print(value) end
end

parse_file("historian-hysteria-input.txt")
