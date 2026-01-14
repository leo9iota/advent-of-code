local function read_input(filename)
    local left_list = {}
    local right_list = {}
    for line in io.lines(filename) do
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
    for i = 1, #left_list do
        total_distance = total_distance + math.abs(left_list[i] - right_list[i])
    end
    return total_distance
end

local function calculate_similarity(left_list, right_list)
    local total_similarity_score = 0
    local right_freq = {}

    for _, num in ipairs(right_list) do
        right_freq[num] = (right_freq[num] or 0) + 1
    end

    for _, num in ipairs(left_list) do
        local count = right_freq[num] or 0
        total_similarity_score = total_similarity_score + num * count
    end

    return total_similarity_score
end

local function main()
    local input_file = "historian-hysteria-input.txt"
    local left_list, right_list = read_input(input_file)
    local total_distance = calculate_distance(left_list, right_list)
    local total_similarity_score = calculate_similarity(left_list, right_list)
    print("Distance:", total_distance)
    print("Similarity:", total_similarity_score)
end

main()
