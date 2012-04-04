width = 76;
height = 28;

offset = 25;
cutout = 13;
middle = 2*offset - width/2;

module parallel_joints() {
	difference() {
		union() {
			intersection() {
				cube([width, 20, 8], center=true);
				rotate([0, 90]) cylinder(r=5, h=width, center=true);
			}
			translate([0, 8, 0]) cube([width, 16, 8], center=true);
		}
		rotate([0, 90, 0]) cylinder(r=1.55, h=80, center=true, $fn=12);

		for (x = [-offset, offset]) {
			translate([x, 5.5, 0])
				cylinder(r=cutout/2, h=10, center=true, $fn=24);
			translate([x, -4.5, 0])
				cube([cutout, 20, 10], center=true);
			translate([x, 0, 0]) rotate([0, 90, 0]) rotate([0, 0, 30])
				cylinder(r=3.3, h=17, center=true, $fn=6);
		}
		translate([0, 2, 0]) cylinder(r=middle, h=10, center=true);
		translate([0, -8, 0]) cube([2*middle, 20, 10], center=true);
	}
}

module lm8uu_mount() {
	union() {
		difference() {
			intersection() {
				cylinder(r=10.7, h=height, center=true);
				translate([0, -8, 0]) cube([18, 12, 30], center=true);
			}
			cylinder(r=7.5, h=height+1, center=true);
		}
		difference() {
			intersection() {
				cylinder(r=10, h=height, center=true);
				translate([0, -8, 0]) cube([20, 4, height], center=true);
			}
			cylinder(r=7.5, h=24.4, center=true);
		}
	}
}

module carriage() {
	union() {
		for (x = [-30, 30]) {
			translate([x, 0, 0]) lm8uu_mount();
		}
		difference() {
			union() {
				translate([0, -6, 0])
					cube([50, 4, height], center=true);
				translate([0, -22, -height/2+4])
					parallel_joints();
			}
			for (x = [-30, 30]) {
				translate([x, 0, 0])
					cylinder(r=8, h=height+1, center=true);
				for (z = [-4.495, 4.5])
					translate([x, 0, z])
						cylinder(r=13, h=3, center=true);
			}
		}
		difference() {
			translate([8, 2, 0]) cube([4, 13, height], center=true);
			for (z = [-4.95, 4.5])
				translate([8, 5, z])
					cube([5, 13, 3], center=true);
		}
		for (y = [1.5, 5, 8.5]) {
			translate([8, y, 0]) cube([4, 0.9, height], center=true);
		}
	}
}

translate([0, 0, height/2]) carriage();
