use <linear_bushing.scad>;

height = 16;

offset = 20;
cutout = 12;

module parallel_joints() {
	difference() {
		union() {
			translate([0, 1, 0])
			intersection() {
				cube([60, 20, 8], center=true);
				rotate([0, 90]) cylinder(r=5, h=60, center=true);
			}
			translate([0, 10, 0]) cube([60, 20, 8], center=true);
		}
		rotate([0, 90, 0]) cylinder(r=1.55, h=80, center=true, $fn=12);

		for (x = [-offset, offset]) {
			translate([x, 6, 0])
				cylinder(r=cutout/2, h=10, center=true, $fn=24);
			translate([x, -4, 0])
				cube([cutout, 20, 10], center=true);
		}
		translate([0, 2, 0]) {
			cylinder(r=10, h=10, center=true);
			translate([0, -5, 0]) cube([20, 10, 10], center=true);
		}
	}
}

rotate([0, 0, 45])
difference() {
union() {
	difference() {
		union() {
			translate([0, -4, 0]) cube([60, 8, height], center=true);

			for (x = [-30, 30]) {
				translate([x, -1.5, 0])
					cylinder(r=10, h=height, center=true, $fn=36);
			}

			translate([0, -20, -height/2+4]) parallel_joints();
		}
		for (x = [-30, 30]) {
			translate([x, 0, 0])
				cylinder(r=7, h=height+1, center=true);
			translate([x, 15, 0])
				cylinder(r=13, h=height+1, center=true);
			translate([x, -22, 2.01]) rotate([0, 0, x])
				cube([1.5, 60, 4], center=true);
			translate([x*0.51, 1, 0])
				cylinder(r=5, h=height+1, center=true, $fn=24);
		}

		cube([30, 8, height+1], center=true);
	}
	for (x = [-30, 30]) {
		translate([x, 0, 4])
			linear_bushing(inside_diameter=8, inside_factor=0.975,
						   outside_diameter=15,
						   height=24, sides=16, angle=20, wall=0.9);
	}
	translate([8, 2, 0]) cube([3.5, 13, height], center=true);
}
	translate([8, 3, 3]) cube([5, 9, 3], center=true);
	translate([8, 3, -3]) cube([5, 9, 3], center=true);
}
