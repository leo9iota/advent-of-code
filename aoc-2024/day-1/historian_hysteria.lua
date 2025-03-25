-- Part 1
local function read_input(filename)
    local left_list = {}
    local right_list = {}
    for line in io.lines(filename) do -- Parse line by line
        local left, right = line:match("(%d+)%s+(%d+)") -- Use same pattern as before
        if left and right then
            table.insert(left_list, tonumber(left))
            table.insert(right_list, tonumber(right))
        end
    end
    return left_list, right_list
end

local function calculate_distance(left_list, right_list)
    table.sort(left_list)
    table.sort(right_list)
    local total_distance = 0
    for i = 1, #left_list do total_distance = total_distance + math.abs(left_list[i] - right_list[i]) end -- The # operator gets the length of the table (Lua has a 1-based index btw)
    return total_distance
end

-- Part 2
local function calc_similarity(left_list, right_list)
    local total_similarity_score

    return total_similarity_score
end

local function main()
    local input_file = "historian-hysteria-input.txt"
    local left_list, right_list = read_input(input_file)
    local total_distance = calculate_distance(left_list, right_list)
    print("Total distance: " .. total_distance)
end

main()
