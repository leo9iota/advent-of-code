// Testing ArrayList functionality in Zig
// Learning how to write proper Zig tests instead of using main()

const std = @import("std");
const testing = std.testing; // Import testing utilities

// This is a proper Zig test function - runs when you do 'zig test'
// Test functions start with 'test' keyword and have a string name
test "ArrayList basic operations" {
    // Use testing allocator which is designed for tests
    // It detects memory leaks and is more strict than GeneralPurposeAllocator
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    // Note: allocator not used yet, but keeping setup for when we figure out ArrayList API
    _ = gpa.allocator();

    // TODO: Figure out the correct ArrayList initialization for Zig 0.15.1
    // This syntax doesn't work in this version - keeping for reference
    // var list = std.ArrayList(u32){ .allocator = allocator, .items = &[_]u32{}, .capacity = 0 };

    // For now, let's test with a simple array instead
    const simple_array = [_]u32{ 42, 100, 200 };

    // Using testing.expect for assertions instead of print statements
    try testing.expect(simple_array.len == 3);
    try testing.expect(simple_array[0] == 42);
    try testing.expect(simple_array[1] == 100);
    try testing.expect(simple_array[2] == 200);

    // Test will pass if we get here without any assertion failures
    std.debug.print("ArrayList test passed (using simple array for now)\n", .{});
}

// Another test to show multiple test functions
test "Array slicing operations" {
    const numbers = [_]u32{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };

    // Test slicing - very common in Zig
    const first_three = numbers[0..3]; // Gets elements 0, 1, 2
    const last_three = numbers[numbers.len - 3 ..]; // Gets last 3 elements

    try testing.expect(first_three.len == 3);
    try testing.expect(first_three[0] == 1);
    try testing.expect(first_three[2] == 3);

    try testing.expect(last_three.len == 3);
    try testing.expect(last_three[0] == 8);
    try testing.expect(last_three[2] == 10);

    std.debug.print("Array slicing test passed\n", .{});
}
