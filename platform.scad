use <joint.scad>;

width = 80;
offset = 20;
height = 6;
cutout = 12.5;
inset = 6;
radius = width/2 - inset;
radius2 = width/2 - 4;

difference() {
	union() {
		cube([width, width, height], center=true);
		for (a = [0, 90, 180, 270]) {
			rotate([0, 0, a]) {
				translate([0, width/2, 0])
				rotate([0, 90, 0]) rotate([0, 0, 30])
					cylinder(r=3.46, h=2*radius2-cutout, center=true, $fn=6);
			}
		}
	}
	cylinder(r=20, h=20, center=true);
	translate([0, 0, 5]) cube([50, 50, 10], center=true);
	rotate([0, 0, 26]) translate([0, 0, 5]) cube([47, 47, 10], center=true);
	rotate([0, 0, -26]) translate([0, 0, 5]) cube([47, 47, 10], center=true);
	for (a = [15 : 30 : 374]) {
		rotate([0, 0, a]) {
			translate([25, 0, 0]) cylinder(r=2.2, h=10, center=true, $fn=12);
		}
	}
	for (a = [0, 90, 180, 270]) {
		rotate([0, 0, a]) {
			// translate([15, 15, 0]) cylinder(r=17, h=10);
			translate([0, -width/2+1, 0]) cylinder(r=10, h=10, center=true);
			translate([0, -width/2-4, 0]) cube([20, 10, 10], center=true);
			translate([0, -width/2+1, 0]) rotate([0, 90])
				cylinder(r=1.6, h=width, center=true, $fn=12);
			for (x = [-offset, offset]) {
				translate([x, -radius, 0])
					cylinder(r=cutout/2, h=20, center=true, $fn=24);
				translate([x, -width/2, 0])
					cube([cutout, 2*inset, 20], center=true);
			}
			translate([radius2, radius2, 0])
				cylinder(r=cutout/2, h=20, center=true, $fn=24);
			translate([radius2, width/2, 0])
				cube([cutout, inset, 20], center=true);
			translate([width/2, radius2, 0])
				cube([inset, cutout, 20], center=true);
		}
	}
}

/*
for (a = [0, 90, 180, 270]) {
	rotate([0, 0, a]) {
		for (x = [-offset, offset]) {
			translate([x, width/2-1, 0])
				rotate([-30]) middle();
		}
	}
}
*/
