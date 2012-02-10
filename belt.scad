// GT2 belt
belt_pitch = 2;
belt_width = 6;

module timing_belt(length) {
	color([0.1, 0.1, 0.1])
	union() {
		cube([length, belt_width, 1], center=true);
		// for (i = [0 : (length / pitch)]) {
		// 	translate([pitch*i - length/2, 0, -0.7])
		// 	cube([1, belt_width, 1], center=true);
		// }
    }
}

module timing_belt_loop() {
	translate([(end_idler_x - end_idler_x2) / 2, 0, end_idler_z + 9])
		rotate([0, 180, 0]) timing_belt(end_idler_x + end_idler_x2);
	translate([(end_idler_x + idler_x) / 2, 0, idler_z - 9])
		timing_belt(end_idler_x - idler_x);
	translate([-(end_idler_x2 + idler_x) / 2, 0, idler_z - 9])
		timing_belt(end_idler_x2 - idler_x);
	translate([-end_idler_x2 - 9, 0, (idler_z + end_idler_z) / 2])
		rotate([0, 90, 0]) timing_belt(end_idler_z - idler_z);
}

// Long timing belt loops
timing_belt_loop(2, 6);
mirror([0, 0, 1]) timing_belt_loop(2, 6);
