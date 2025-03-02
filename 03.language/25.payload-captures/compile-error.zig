const expect = @import("std").testing.expect;

const Info = union(enum) {
    a: u32,
    b: []const u8,
    c,
    d: u32,
};

test "error: union initialization expects exactly one field" {
    const b = Info{ .a = 10, .b = [_]u8{1} };
    const x = switch (b) {
        .b => |str| blk: {
            try expect(@TypeOf(str) == []const u8);
            break :blk 1;
        },
        .c => {
            return 2;
        },
        .a, .d => |num| blk: {
            try expect(@TypeOf(num) == u32);
            break :blk num * 2;
        },
    };
    try expect(x == 20);
}

test "error: expected type 'anyerror!void', found 'u32'" {
    const b = Info{ .a = 10 };
    const x = switch (b) {
        .b => |str| {
            try expect(@TypeOf(str) == []const u8);
            return 1;
        },
        .c => {
            return 2;
        },
        .a, .d => |num| {
            try expect(@TypeOf(num) == u32);
            return num * 2;
        },
    };
    try expect(x == 20);
}
