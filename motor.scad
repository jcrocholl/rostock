$fa = 12;
$fs = 0.5;

h = 44; // Height
w = 60; // Smooth rod distance (center to center)
m = 29; // Motor mounting screws distance (center to center)

module motor_end() {
	difference() {
		union() {
			translate([0, 0, 0]) cube([w+12, 20, h], center=true);
			// Sandwich mount
			translate([-w/2, 10, 0]) cylinder(r=6, h=h, center=true);
			translate([w/2, 10, 0]) cylinder(r=6, h=h, center=true);
		}
		// Sandwich mount
		translate([-w/2, 12, 0]) cylinder(r=2.2, h=h+1, center=true);
		translate([w/2, 12, 0]) cylinder(r=2.2, h=h+1, center=true);
		// Smooth rod and mounting slots
		for (x = [-w/2, w/2]) {
			translate([x, 0, 0]) {
				cylinder(r=4.2, h=h+1, center=true);
				translate([0, -10, 0]) cube([2, 20, h+1], center=true);
				for (z = [-h/2+8, 0, h/2-8]) {
					// M3 screw hole
					translate([0, -6, z]) rotate([0, 90, 0])
						cylinder(r=1.6, h=20, center=true);
					// M3 nut holder
					translate([-x/5, -6, z])
						rotate([30, 0, 0]) rotate([0, 90, 0])
						cylinder(r=3.2, h=2.3, center=true, $fn=6);
				}
			}
		}
		// Belt path
		translate([0, -6, 0]) cube([w-20, 20, h+1], center=true);
		translate([0, -10, 0]) cube([w-12, 20, h+1], center=true);
		translate([-w/2+10, 0, 0]) cylinder(r=4, h=h+1, center=true);
		translate([w/2-10, 0, 0]) cylinder(r=4, h=h+1, center=true);
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
	}
}

motor_end();
