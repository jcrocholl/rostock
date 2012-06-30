use <belt.scad>;
use <bearing.scad>;
use <nema.scad>;
use <motor_end.scad>;
use <idler_end.scad>;
use <carriage.scad>;
use <platform.scad>;
use <rod.scad>;

aluminum = [0.9, 0.9, 0.9];
steel = [0.8, 0.8, 0.9];

tower_radius = 154;
joint_radius = 108;
motor_radius = 165;
carriage_z = 300;
rod_length = 250;
z0 = 120;

module smooth_rod(z) {
	color(steel) cylinder(r=4, h=762);
	translate([0, 0, z]) lm8uu();
}

module tower(z) {
	translate([0, tower_radius, 0]) {
		translate([0, 0, 30]) rotate([0, 0, 180]) motor_end();
		translate([30, 0, 0]) smooth_rod(z0+z-14);
		translate([-30, 0, 0]) smooth_rod(z0+z-14);
		translate([0, 0, z0+z-14]) rotate([0, 180, 0]) carriage();
	}
	translate([0, motor_radius, 0]) {
		translate([0, 0, 30]) nema17(47);
		// Ball bearings for timing belt
		translate([7, 0, 750]) bearing(8, 22, 7);
		// Timing belt
		translate([-12, 0, 390]) rotate([0, 90, 0]) timing_belt(720);
		translate([12, 0, 390]) rotate([0, 90, 0]) timing_belt(720);
	}
}

module rod_pair(x, y, rotate_z, elevation, azimuth) {
	translate([x, y, z0+94]) {
		rotate([0, 0, rotate_z]) translate([25, 82, 0])
			rotate([0, 0, azimuth]) rotate([elevation, 0, 0])
			rotate([-azimuth, 0, 90]) rotate([90, 0, 0]) rod(rod_length);
		rotate([0, 0, rotate_z]) translate([-25, 82, 0])
			rotate([0, 0, azimuth]) rotate([elevation, 0, 0])
			rotate([-azimuth, 0, 90]) rotate([90, 0, 0]) rod(rod_length);
	}
}

translate([0, 0, -160]) {
	for (a = [0:120:359]) rotate([0, 0, a]) {
		tower(215);
		rod_pair(0, 0, a, elevation=67, azimuth=0);
	}

	translate([0, 0, 100]) rotate([0, 0, 60]) platform();

	% translate([0, 0, 58])
		  cylinder(r=tower_radius*1.11, h=12, center=true, $fn=6);
	color([0.9, 0, 0]) translate([0, 0, 65])
		cube([215, 215, 2], center=true);
}
