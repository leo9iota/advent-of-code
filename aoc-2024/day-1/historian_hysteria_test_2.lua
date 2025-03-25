local left_list = {
    3,
    4,
    2,
    1,
    3,
    3
}

local right_list = {
    4,
    3,
    5,
    3,
    9,
    3
}

table.sort(left_list)
table.sort(right_list)

-- Helper function to print table contents
local function print_table(tbl)
    for _, v in ipairs(tbl) do io.write(v .. " ") end
    print() -- Newline
end

print("Left List:")
print_table(left_list)

print("Right List:")
print_table(right_list)

local function calculate_similarity(left_list, right_list)
    for i = 1, #left_list do
        print(left_list[i])
        for j = 1, #right_list do
            print("Left list: " .. left_list[i] .. " => " .. "right list: " .. right_list[j])
        end
    end
end

calculate_similarity(left_list, right_list)
