const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const file = std.fs.cwd().openFile("calorie-counting-input.txt", .{}) catch |err| {
        std.debug.print("Error opening file: {}\n", .{err});
        return;
    };
    defer file.close();

    const contents = try file.readToEndAlloc(allocator, 1024 * 1024);
    defer allocator.free(contents);

    var elf_calories: [1000]u32 = undefined;
    var elf_count: usize = 0;

    var lines = std.mem.splitScalar(u8, contents, '\n');
    var current_elf_total: u32 = 0;

    while (lines.next()) |line| {
        const trimmed_line = std.mem.trim(u8, line, " \r\n\t");

        if (trimmed_line.len == 0) {
            if (current_elf_total > 0) {
                elf_calories[elf_count] = current_elf_total;
                elf_count += 1;
                current_elf_total = 0;
            }
        } else {
            const calories = std.fmt.parseInt(u32, trimmed_line, 10) catch |err| {
                std.debug.print("Error parsing number '{s}': {}\n", .{ trimmed_line, err });
                continue;
            };
            current_elf_total += calories;
        }
    }

    if (current_elf_total > 0) {
        elf_calories[elf_count] = current_elf_total;
        elf_count += 1;
    }

    var max_calories: u32 = 0;
    for (elf_calories[0..elf_count]) |calories| {
        if (calories > max_calories) {
            max_calories = calories;
        }
    }

    std.debug.print("Part 1: Elf with most calories: {} calories\n", .{max_calories});

    std.mem.sort(u32, elf_calories[0..elf_count], {}, std.sort.desc(u32));

    var top_three_total: u32 = 0;
    const top_count = @min(3, elf_count);
    for (elf_calories[0..top_count]) |calories| {
        top_three_total += calories;
    }

    std.debug.print("Part 2: Top 3 elves total calories: {} calories\n", .{top_three_total});
}
