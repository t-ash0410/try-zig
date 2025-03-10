const std = @import("std");
const expect = std.testing.expect;

test "split iterator" {
    const text = "robust, optimal, reusable, maintainable, ";
    var iter = std.mem.split(u8, text, ", ");
    try expect(std.mem.eql(u8, iter.next().?, "robust"));
    try expect(std.mem.eql(u8, iter.next().?, "optimal"));
    try expect(std.mem.eql(u8, iter.next().?, "reusable"));
    try expect(std.mem.eql(u8, iter.next().?, "maintainable"));
    try expect(std.mem.eql(u8, iter.next().?, ""));
    try expect(iter.next() == null);
}

test "iterator looping" {
    var iter = (try std.fs.cwd().openDir(
        ".",
        .{ .iterate = true },
    )).iterate();

    var file_count: usize = 0;
    while (try iter.next()) |entry| {
        if (entry.kind == .file) file_count += 1;
    }

    try expect(file_count > 0);
}

const ContainsIterator = struct {
    strings: []const []const u8,
    needle: []const u8,
    index: usize = 0,

    fn next(self: *ContainsIterator) ?[]const u8 {
        const index = self.index;
        for (self.strings[index..]) |string| {
            self.index += 1;
            if (std.mem.indexOf(u8, string, self.needle)) |_| {
                return string;
            }
        }
        return null;
    }
};

test "custom iterator" {
    var iter = ContainsIterator{
        .strings = &[_][]const u8{ "one", "two", "three" },
        .needle = "e",
    };

    try expect(std.mem.eql(u8, iter.next().?, "one"));
    try expect(std.mem.eql(u8, iter.next().?, "three"));
    try expect(iter.next() == null);
}
