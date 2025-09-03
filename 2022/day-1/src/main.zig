const std = @import("std"); // Import standard library (similar to #include in C)

// Entry point. The '!' means it can return an error (error union type in Zig)
// In Zig, errors are part of the type system, not exceptions like in other languages (Java)
pub fn main() !void {
    // Setting up memory allocator. Zig requires explicit memory management
    // GeneralPurposeAllocator handles basic allocation/deallocation
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    // 'defer' runs when function exits - like RAII destructors but more explicit
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Read the input file
    // In Zig, you need to handle file operations explicitly
    // The 'catch' handles the error case - like try/catch but built into the type system
    const file = std.fs.cwd().openFile("calorie-counting-input.txt", .{}) catch |err| {
        std.debug.print("Error opening file: {}\n", .{err});
        return; // Early return on error
    };
    defer file.close(); // Make sure file gets closed when function exits

    // Read entire file into memory
    // 1024 * 1024 = 1MB max file size (should be plenty for advent of code)
    // 'try' is shorthand for 'catch |err| return err' - propagates errors up
    const contents = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(contents); // Free the memory when done - no garbage collector!

    // Store each elf's total calories
    // I'm using a fixed-size array instead of dynamic ArrayList because I'm still learning
    // ArrayList was giving me trouble with the API in this Zig version
    var elf_calories: [1000]u32 = undefined; // 'undefined' means uninitialized (like malloc)
    var elf_count: usize = 0; // Keep track of how many elves we've processed

    // Split the file contents by newlines
    // splitScalar splits by a single character (the newline)
    var lines = std.mem.splitScalar(u8, contents, '\n');
    var current_elf_total: u32 = 0; // Running total for current elf

    // Process each line
    // The |line| syntax is like a lambda parameter - captures each line
    while (lines.next()) |line| {
        // Remove whitespace from both ends
        // The string "\r\n\t" includes Windows line endings and tabs
        const trimmed_line = std.mem.trim(u8, line, " \r\n\t");

        // Check if line is empty (blank line separates elves)
        if (trimmed_line.len == 0) {
            // Empty line means we've finished this elf's inventory
            if (current_elf_total > 0) {
                elf_calories[elf_count] = current_elf_total; // Store this elf's total
                elf_count += 1; // Move to next elf
                current_elf_total = 0; // Reset for next elf
            }
        } else {
            // Line has content, so it's a calorie value
            // parseInt converts string to integer, base 10
            // Using catch here to handle invalid numbers gracefully
            const calories = std.fmt.parseInt(u32, trimmed_line, 10) catch |err| {
                // {s} format specifier is needed for string slices in Zig
                std.debug.print("Error parsing number '{s}': {}\n", .{ trimmed_line, err });
                continue; // Skip this line and continue with the next one
            };
            current_elf_total += calories; // Add to this elf's running total
        }
    }

    // Handle the last elf if the file doesn't end with a blank line
    // This is a common edge case in file processing
    if (current_elf_total > 0) {
        elf_calories[elf_count] = current_elf_total;
        elf_count += 1;
    }

    // PART 1: Find the elf carrying the most calories
    var max_calories: u32 = 0;
    // Slice notation [0..elf_count] only processes the elves we actually have
    // |calories| captures each element in the iteration
    for (elf_calories[0..elf_count]) |calories| {
        if (calories > max_calories) {
            max_calories = calories;
        }
    }

    // Print result for part 1
    // {} is the default format specifier for integers
    std.debug.print("Part 1 - Elf with most calories: {} calories\n", .{max_calories});

    // PART 2: Find the sum of the top 3 elves' calories
    // Sort the calories in descending order (highest first)
    // std.sort.desc(u32) creates a comparison function for sorting u32 in descending order
    std.mem.sort(u32, elf_calories[0..elf_count], {}, std.sort.desc(u32));

    // Sum up the top 3 (or fewer if we have less than 3 elves)
    var top_three_total: u32 = 0;
    const top_count = @min(3, elf_count); // @min is a builtin function for minimum of two values
    for (elf_calories[0..top_count]) |calories| {
        top_three_total += calories;
    }

    std.debug.print("Part 2 - Top 3 elves total calories: {} calories\n", .{top_three_total});
}
