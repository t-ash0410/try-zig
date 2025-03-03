const std = @import("std");
const expect = std.testing.expect;
const eql = std.mem.eql;
const test_allocator = std.testing.allocator;

const Place = struct { lat: f32, long: f32 };

test "json parse" {
    const parsed = try std.json.parseFromSlice(
        Place,
        test_allocator,
        \\{ "lat": 40.684540, "long": -74.401422 }
    ,
        .{},
    );
    defer parsed.deinit();

    const place = parsed.value;

    try expect(place.lat == 40.684540);
    try expect(place.long == -74.401422);
}

test "json stringify" {
    const x = Place{
        .lat = 51.997664,
        .long = -0.740687,
    };

    var buf: [100]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);
    var string = std.ArrayList(u8).init(fba.allocator());
    defer string.deinit();

    try std.json.stringify(x, .{}, string.writer());

    try expect(eql(
        u8,
        string.items,
        \\{"lat":5.199766540527344e1,"long":-7.406870126724243e-1}
        ,
    ));
}

test "json parse with strings" {
    const User = struct { name: []u8, age: u16 };

    const parsed = try std.json.parseFromSlice(
        User,
        test_allocator,
        \\{ "name": "Joe", "age": 25 }
    ,
        .{},
    );
    defer parsed.deinit();

    const user = parsed.value;

    try expect(eql(u8, user.name, "Joe"));
    try expect(user.age == 25);
}
