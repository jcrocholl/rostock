use <bracket.scad>;

$fa = 12;
$fs = 0.5;

h = 44; // Total height.
m = 29; // Motor mounting screws distance (center to center)

module motor_end() {
	difference() {
		bracket(h);
		// Motor shaft (RepRap logo)
		rotate([90]) cylinder(r=12, h=40, center=true);
		translate([0, 0, sin(45)*12]) rotate([0, 45])
			cube([12, 40, 12], center=true);
		// Motor mounting screw slots
		translate([m/2, 0, m/2]) rotate([0, -45])
			cube([9, 40, 3], center=true);
		translate([-m/2, 0, m/2]) rotate([0, 45])
			cube([9, 40, 3], center=true);
		translate([m/2, 0, -m/2]) rotate([0, 45])
			cube([9, 40, 3], center=true);
		translate([-m/2, 0, -m/2]) rotate([0, -45])
			cube([9, 40, 3], center=true);
		for (z = [-14, 0, 14]) {
			translate([0, 0, z]) screws();
		}
	}
}

translate([0, 0, h/2]) motor_end();
