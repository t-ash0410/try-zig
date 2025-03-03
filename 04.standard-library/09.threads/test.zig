const std = @import("std");
const expect = std.testing.expect;
const eql = std.mem.eql;
const test_allocator = std.testing.allocator;

var tick: isize = 0;

fn ticker(step: u8) void {
    while (true) {
        std.time.sleep(1 * std.time.ns_per_s);
        tick += @as(isize, step);
    }
}

test "threading" {
    const thread = try std.Thread.spawn(.{}, ticker, .{@as(u8, 1)});
    _ = thread;
    try expect(tick == 0);
    std.time.sleep(3 * std.time.ns_per_s / 2);
    try expect(tick == 1);
}
