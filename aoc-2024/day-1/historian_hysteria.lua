local location_id = 0 -- Location ID variable used to calculate distance

function parse_file(path)
    local file = io.open(path, "r") -- Parse input file

    if not file then error("Could not open file") end -- Print error message if file couldn't be parsed

    for line in file:lines() do
        print(line) -- process each line
    end

    file:close() -- IMPORTANT! Close file after processing it
end

parse_file("historian-hysteria-input.txt")
