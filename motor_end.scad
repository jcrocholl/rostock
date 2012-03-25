$fa = 12;
$fs = 0.5;

w = 60; // Smooth rod distance (center to center)
m = 29; // Motor mounting screws distance (center to center)

module screws() {
	for (x = [-w/2, w/2]) {
		translate([x, 0, 0]) {
			// M3 screw hole
			translate([0, -6, 0]) rotate([0, 90, 0])
				cylinder(r=1.65, h=20, center=true);
			// M3 nut holder
			translate([-x/5, -6, 0])
				rotate([30, 0, 0]) rotate([0, 90, 0])
				# cylinder(r=3.2, h=2.3, center=true, $fn=6);
		}
	}
}

module bracket(h) {
	difference() {
		union() {
			translate([0, -1, 0]) cube([w+12, 22, h], center=true);
			// Sandwich mount
			translate([-w/2, 10, 0]) cylinder(r=6, h=h, center=true);
			translate([w/2, 10, 0]) cylinder(r=6, h=h, center=true);
		}
		// Sandwich mount
		translate([-w/2, 12, 0]) cylinder(r=1.9, h=h+1, center=true);
		translate([w/2, 12, 0]) cylinder(r=1.9, h=h+1, center=true);
		// Smooth rod and mounting slots
		for (x = [-w/2, w/2]) {
			translate([x, 0, 0]) {
				cylinder(r=4.2, h=h+1, center=true);
				translate([0, -10, 0]) cube([2, 20, h+1], center=true);
			}
		}
		// Belt path
		translate([0, -4, 0]) cube([w-20, 20, h+1], center=true);
		translate([0, -8, 0]) cube([w-12, 20, h+1], center=true);
		translate([-w/2+10, 2, 0]) cylinder(r=4, h=h+1, center=true);
		translate([w/2-10, 2, 0]) cylinder(r=4, h=h+1, center=true);
	}
}

module motor_end() {
	difference() {
		bracket(44);
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

rotate([0, 0, 45]) motor_end();
