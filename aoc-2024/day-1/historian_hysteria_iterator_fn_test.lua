local mixedTable = {
    [1] = "apple",
    [2] = "banana",
    [4] = "orange",
    ["color"] = "red",
}

print("Using pairs():")
for key, value in pairs(mixedTable) do
    print("Key:", key, "Value:", value)
end

print("\nUsing ipairs():")
for index, value in ipairs(mixedTable) do
    print("Index:", index, "Value:", value)
end
