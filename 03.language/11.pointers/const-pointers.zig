test "const pointers" {
    const x: u8 = 1;
    var y = &x; // compile error
    y.* += 1;
}
