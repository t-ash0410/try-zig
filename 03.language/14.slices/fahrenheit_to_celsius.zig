const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const args = try std.process.argsAlloc(std.heap.page_allocator);
    defer std.process.argsFree(std.heap.page_allocator, args);

    if (args.len < 2) return error.ExpectedArgument;

    for (args, 0..) |arg, i| {
        if (i == 0) continue;
        try stdout.print("arg {}: {s}\n", .{ i, arg });
    }

    const f = try std.fmt.parseFloat(f32, args[1]);
    const c = (f - 32) * (5.0 / 9.0);
    try stdout.print("{d:.1}c\n", .{c});
}
