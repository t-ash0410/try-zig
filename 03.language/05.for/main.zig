const std = @import("std");

pub fn main() void {
    const string = [_]u8{ 'a', 'b', 'c' };
    for (string, 0..) |character, index| {
        std.debug.print("string[{d}] => {c}\n", .{ index, character });
    }
    for (string) |character| {
        _ = character;
    }
    for (string, 0..) |_, index| {
        _ = index;
    }
    for (string) |_| {
        std.debug.print("Hello!\n", .{});
    }
}
