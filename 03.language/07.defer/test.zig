test "defer" {
    var x: i16 = 5;
    {
        defer x += 2;
        try @import("std").testing.expect(x == 5);
    }
    try @import("std").testing.expect(x == 7);
}

test "multi defer" {
    var x: f32 = 5;
    {
        defer x += 2;
        defer x /= 2;
    }
    // 5 / 2 = 2.5 -> 2.5 + 2 = 4.5
    try @import("std").testing.expect(x == 4.5);
}
