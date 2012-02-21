use <pulley.scad>;
use <belt.scad>;
use <bearing.scad>;
use <nema.scad>;
use <motor_end.scad>;

aluminum = [0.9, 0.9, 0.9];
carbon = [0.1, 0.1, 0.1];
steel = [0.8, 0.8, 0.9];

tower_radius = 178;
joint_radius = 108;
motor_radius = 185;
carriage_z = 300;
rod_length = 265;
z0 = 120;

module platform() {
	difference() {
		cube([100, 100, 12], center=true);
		cylinder(r=20, h=20, center=true);
		for (a = [0, 90, 180, 270])
			rotate([0, 0, a]) {
				translate([63, 43, 0]) cube([40, 40, 40], center=true);
				translate([43, 63, 0]) cube([40, 40, 40], center=true);
				translate([43, 43, 0]) cylinder(r=20, h=40, center=true);
			}
	}
	for (a = [0, 90, 180, 270])
		rotate([0, 0, a]) {
			translate([-30, 45, 0]) ball();
			translate([30, 45, 0]) ball();
		}
}

module ball() {
	color(steel) rotate([0, 90]) difference() {
		sphere(r=7);
		cylinder(r=3, h=20, center=true);
	}
}

module rod_end() {
	rotate([90, 0, 0]) {
		color([0.4, 0.4, 0.4]) difference() {
			union() {
				cylinder(r=9, h=6, center=true);
				translate([10, 0, 0]) rotate([0, 90, 0])
					cylinder(r=5, h=20, center=true);
			}
			cylinder(r=6, h=20, center=true);
		}
	}
}

module rod(length) {
	rod_end();
	translate([length, 0, 0]) rotate([0, 0, 180]) rod_end();
	color(carbon) translate([length/2, 0, 0]) rotate([0, 90, 0])
		cylinder(r=3, h=length-20, center=true);
}

module shaft(z) {
	color(steel) cylinder(r=4, h=762);
	translate([0, 0, z]) lm8uu();
}

module z_carriage() {
	difference() {
		union() {
			translate([0, 10, 0]) cube([80, 6, 40], center=true);
			translate([0, 17, 14]) cube([46, 14, 12], center=true);
			translate([0, 24, 14]) rotate([0, 90, 0])
				cylinder(r=6, h=46, center=true);
			translate([10, -3, 0]) cube([10, 30, 40], center=true);
		}
		translate([0, 24, 14]) rotate([0, 90, 0])
			cylinder(r=3, h=50, center=true);
		translate([30, 0, 0]) cylinder(r=8, h=26, center=true);
		translate([-30, 0, 0]) cylinder(r=8, h=26, center=true);
	}
	translate([-30, 25, 14]) ball();
	translate([30, 25, 14]) ball();
}

module tower(z) {
	translate([0, tower_radius, 0]) {
		translate([0, 0, 30]) rotate([0, 0, 180]) motor_end();
		translate([30, 0, 0]) shaft(z0+z-14);
		translate([-30, 0, 0]) shaft(z0+z-14);
		translate([0, 0, z0+z-14]) rotate([0, 0, 180]) z_carriage();
	}
	translate([0, motor_radius, 0]) {
		translate([0, 0, 30]) nema17(47);
		// Ball bearings for timing belt
		translate([7, 0, 750]) bearing(8, 22, 7);
		// Timing belt
		translate([-4, 0, 390]) rotate([0, 90, 0]) timing_belt(720);
		translate([11, 0, 390]) rotate([0, 91.1, 0]) timing_belt(720);
	}
}

function animate_x() =
	$t < 0.33333333 ? 3*$t*200-100 :
	$t < 0.66666666 ? 100 :
	3*(1-$t)*200-100;

function animate_y() =
	$t < 0.33333333 ? 100 :
	$t < 0.66666666 ? 3*(0.66666666-$t)*200-100 :
    -100;

function animate_x4() =
	$t < 0.25 ? 4*$t*200-100 :
	$t < 0.5 ? 100 :
	$t < 0.75 ? 4*(0.75-$t)*200-100 :
	-100;

function animate_y4() =
	$t < 0.25 ? 100 :
	$t < 0.5 ? 4*(0.5-$t)*200-100 :
	$t < 0.75 ? -100 :
	4*($t-0.75)*200-100;

function animate_x5() =
	$t < 0.2 ? 5*$t*200-100 :
	$t < 0.4 ? 100 :
	$t < 0.6 ? 5*(0.6-$t)*200-100 :
	$t < 0.8 ? -100 :
	5*($t-0.8)*200-100;

function animate_y5() =
	$t < 0.2 ? 100 :
	$t < 0.4 ? 5*(0.4-$t)*200-100 :
	$t < 0.6 ? -100 :
	$t < 0.8 ? 5*($t-0.6)*200-100 :
	100;

function animate_z(x, y) =
	sqrt(pow(rod_length, 2) -
		 pow(animate_x() - x, 2) -
		 pow(animate_y() - y, 2));

module rod_pair(x, y, rotate_z, elevation, azimuth) {
	translate([x, y, z0]) {
		rotate([0, 0, rotate_z]) translate([30, 45, 0])
			rotate([0, 0, azimuth]) rotate([elevation])
			rotate([-azimuth, 0, 90]) rod(rod_length);
		rotate([0, 0, rotate_z]) translate([-30, 45, 0])
			rotate([0, 0, azimuth]) rotate([elevation])
			rotate([-azimuth, 0, 90]) rod(rod_length);
	}
}

rotate([0, 0, $t*90])
translate([0, 0, -160]) {
	assign(x = animate_x())
	assign(y = animate_y()) {
		assign(z = animate_z(0, joint_radius))
		assign(distance = sqrt(pow(x, 2) + pow(joint_radius - y, 2)))
		assign(elevation = 90 - atan2(distance, z))
		assign(azimuth = atan2(x, joint_radius - y)) {
			echo("x", x, "y", y, "z", z, "distance", distance,
				 "elevation", elevation, "azimuth", azimuth);
			tower(z);
			rod_pair(x, y, 0, elevation, azimuth);
		}

		assign(z = animate_z(joint_radius, 0))
		assign(distance = sqrt(pow(joint_radius - x, 2) + pow(y, 2)))
		assign(elevation = 90 - atan2(distance, z))
		assign(azimuth = atan2(-y, joint_radius - x)) {
			rotate([0, 0, -90]) tower(z);
			rod_pair(x, y, -90, elevation, azimuth);
		}

		assign(z = animate_z(0, -joint_radius))
		assign(distance = sqrt(pow(x, 2) + pow(-joint_radius - y, 2)))
		assign(elevation = 90 - atan2(distance, z))
		assign(azimuth = 180 - atan2(-x, -joint_radius - y)) {
			rotate([0, 0, 180]) tower(z);
			rod_pair(x, y, 180, elevation, azimuth);
		}

		assign(z = animate_z(-joint_radius, 0))
		assign(distance = sqrt(pow(-joint_radius - x, 2) + pow(y, 2)))
		assign(elevation = 90 - atan2(distance, z))
		assign(azimuth = 180 - atan2(y, -joint_radius - x)) {
			rotate([0, 0, 90]) tower(z);
			rod_pair(x, y, 90, elevation, azimuth);
		}
	}

	translate([animate_x(), animate_y(), z0]) platform();

	% translate([0, 0, 2]) cylinder(r=tower_radius, h=12, center=true);
	% translate([0, 0, 58]) cylinder(r=tower_radius, h=12, center=true);
	color([0.9, 0, 0]) translate([0, 0, 65])
		cube([215, 215, 2], center=true);
}
