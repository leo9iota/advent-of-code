local location_id = 0 -- Location ID variable used to calculate distance
local left_list = {} -- Table for left column in txt file
local right_list = {} -- Table for right column in txt file

--- Function to parse the list
-- @param path The path of the file to parse
function parse_list(path)
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

    file:close() -- IMPORTANT: Close file after processing it

    -- Print the parsed columns
    -- print("Column 1:")
    -- for _, value in ipairs(left_list) do print(value) end

    -- print("Column 2:")
    -- for _, value in ipairs(right_list) do print(value) end
end

--- Function to calculate the distance
-- @param first_list The first list to sort 
-- @param second_list The second list to sort
-- function calc_distance(first_list, second_list)
--     first_list.sort()
--     second_list.sort()

--     print(first_list, second_list)
-- end

-- -- Fn calls
-- parse_list("historian-hysteria-input.txt")
-- calc_distance(left_list, right_list)


