h = 7;
r = h/2 / cos(30);

module stumpy() {
	rotate([0, 90]) rotate([0, 0, 30]) intersection() {
		cylinder(r=r, h=8, center=true, $fn=6);
		sphere(r=5.1, $fn=24);
	}
}

module middle() {
	difference() {
		union() {
			translate([-2, 0, 0]) stumpy();
			translate([2, 0, 0]) stumpy();
			rotate([0, 0, 90]) stumpy();
		}
		rotate([90]) cylinder(r=1.5, h=30, center=true, $fn=12);
		rotate([0, 90]) cylinder(r=1.5, h=30, center=true, $fn=12);
	}
}

module sides() {
	difference() {
		union() {
			translate([-7, 0, 0]) rotate([0, 90])
				cylinder(r=2, h=4, center=true, $fn=12);
			translate([7, 0, 0]) rotate([0, 90])
				cylinder(r=2, h=4, center=true, $fn=12);
			translate([-7, 5, 0]) cube([4, 10, 4], center=true);
			translate([7, 5, 0]) cube([4, 10, 4], center=true);
		}
		rotate([0, 90]) cylinder(r=0.8, h=20, center=true, $fn=12);
	}
}

module jaws() {
	difference() {
		union() {
			intersection () {
				rotate([90]) cylinder(r=5, h=14, center=true, $fn=24);
				translate([-4, 0, 0]) cube([10, 14, h], center=true);
			}
			intersection() {
				translate([10, 0, 0]) cube([26, 14, h], center=true);
				translate([10, 0, 0]) rotate([0, 90]) rotate([0, 0, 30])
					cylinder(r1=10, r2=r, h=26, center=true, $fn=6);
			}
		}
		translate([-1.5, 0, 0]) cube([10, 8.4, 10], center=true);
		translate([3.5, 0, 0]) rotate([0, 0, 30])
			cylinder(r=4.2, h=10, center=true, $fn=6);
		translate([4, 0, 4]) rotate([0, 45])
			rotate([0, 0, 30]) cylinder(r=4.2, h=8, center=true, $fn=6);
		translate([4, 0, -4]) rotate([0, -45])
			rotate([0, 0, 30]) cylinder(r=4.2, h=8, center=true, $fn=6);
		rotate([90]) cylinder(r=1.55, h=40, center=true, $fn=12);
		translate([19, 0, 0]) rotate([0, 90])
			cylinder(r=2.8, h=20, center=true, $fn=12);
	}
}

// % rotate([0, 50]) middle();
jaws();
