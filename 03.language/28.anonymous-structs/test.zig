const expect = @import("std").testing.expect;

test "anonymous struct literal" {
    const Point = struct { x: i32, y: i32 };

    const pt: Point = .{
        .x = 13,
        .y = 67,
    };
    try expect(pt.x == 13);
    try expect(pt.y == 67);
}

test "fully anonymous struct" {
    try dump(.{
        .int = @as(u32, 1234),
        .float = @as(f64, 12.34),
        .b = true,
        .s = "hi",
    });
}

fn dump(args: anytype) !void {
    try expect(args.int == 1234);
    try expect(args.float == 12.34);
    try expect(args.b);
    try expect(args.s[0] == 'h');
    try expect(args.s[1] == 'i');
}

test "tuple" {
    const values = .{
        @as(u32, 1234),
        @as(f64, 12.34),
        true,
        "hi",
    } ++ .{false} ** 2;
    try expect(values[0] == 1234);
    try expect(values.@"1" == 12.34);
    inline for (values, 0..) |v, i| {
        if (i != 2) continue;
        try expect(v);
    }
    try expect(values.@"3"[0] == 'h');
    try expect(values[3][1] == 'i');
    try expect(values[4] == false);
    try expect(!values[5]);
    try expect(values.len == 6);
}
