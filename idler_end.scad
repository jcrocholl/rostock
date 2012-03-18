use <motor_end.scad>;

$fa = 12;
$fs = 0.5;

w = 60; // Smooth rod distance (center to center)
angle = 91; // Because the timing belt is pulling pretty hard.

module bearing_mount() {
	translate([0, 0, 1.66]) cylinder(r1=12, r2=9, h=1, center=true);
	translate([0, 0, -1.66]) cylinder(r1=9, r2=12, h=1, center=true);
}

module idler_end() {
	difference() {
		union() {
			bracket(28);
			translate([0, 8, 0]) rotate([angle]) bearing_mount();
		}
		translate([0, 8, 0]) rotate([angle])
			cylinder(r=4, h=40, center=true);
		for (z = [-7, 7]) {
			translate([0, 0, z]) screws();
		}
	}
}

idler_end();
