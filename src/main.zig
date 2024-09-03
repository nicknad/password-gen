const std = @import("std");

const letters: []const u8 = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
const numbers: []const u8 = "1234567890";
const special: []const u8 = "!@#$%^&*()_+?|:<.>,';";
const all: []const u8 = letters ++ numbers ++ special;
const length: u8 = 18;

pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();
    const x: u64 = std.zig.c_translation.cast(u64, std.time.nanoTimestamp());
    var prng = std.Random.DefaultPrng.init(x);
    const rand = prng.random();

    try stdout.print("Passsword: \n", .{});

    var i: u8 = 1;
    while (i <= 10) : (i += 1) {
        var result: [length]u8 = undefined;

        for (result, 0..) |_, index| {
            result[index] = all[rand.intRangeAtMost(u8, 0, all.len - 1)];
        }

        try stdout.print("{s} \n", .{result});
    }

    try bw.flush();
}
