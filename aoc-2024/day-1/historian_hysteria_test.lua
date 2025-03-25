local lines = {
    "17633 15737",
    "79440 47531",
    "44767 73309",
    "86871 26386",
    "66575 90774"
}

for _, line in ipairs(lines) do
    local firstColumn, secondColumn = line:match("(%d+)%s+(%d+)")
    if firstColumn and secondColumn then
        print("First: " .. firstColumn .. ", Second: " .. secondColumn)
    else
        print("No match for line: " .. line)
    end
end