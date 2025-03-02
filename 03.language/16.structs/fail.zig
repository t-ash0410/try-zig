const Vec3 = struct { x: f32, y: f32, z: f32 };

test "missing struct field" {
    const my_vector = Vec3{ .x = 0, .y = 100 };
    _ = my_vector;
}
