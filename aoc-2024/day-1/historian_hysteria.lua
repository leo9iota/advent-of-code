-- Part 1
local function read_input(filename)
    local left_list = {}
    local right_list = {}
    -- Parse line by line
    for line in io.lines(filename) do
        -- Use same pattern as before
        local left, right = line:match("(%d+)%s+(%d+)")
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
    -- The # operator gets the length of the table (Lua has a 1-based index btw)
    for i = 1, #left_list do
        total_distance = total_distance + math.abs(left_list[i] - right_list[i])
    end
    return total_distance
end

-- Part 2
local function calculate_similarity(left_list, right_list)
    local total_similarity_score

    for i = 1, #left_list do
        print(left_list[i])
        for j = 1, #right_list do
            print("Left list: " .. left_list[i] .. " => " .. "right list: " .. right_list[j])
        end
    end

    return total_similarity_score
end

local function main()
    local input_file = "historian-hysteria-input.txt"
    local left_list, right_list = read_input(input_file)
    local total_distance = calculate_distance(left_list, right_list)
    local total_similarity_score = calculate_similarity(left_list, right_list)
    print("Total distance: " .. total_distance)
    print("Similarity score: " .. total_similarity_score)
end

main()
