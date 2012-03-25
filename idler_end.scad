use <bracket.scad>;

$fa = 12;
$fs = 0.5;

h = 28; // Total height.
angle = 90 - 1.5; // Because the timing belt is pulling pretty hard.

module bearing_mount() {
	translate([0, 0, 1.66]) cylinder(r1=12, r2=9, h=1.1, center=true);
	translate([0, 0, -1.66]) cylinder(r1=9, r2=12, h=1.1, center=true);
}

module idler_end() {
	difference() {
		union() {
			bracket(h);
			translate([0, 8, 0]) rotate([angle]) bearing_mount();
			// Micro switch placeholder.
			% translate([19, 19, -h/2+4])
				  cube([19.6, 6.34, 10.2], center=true);
			difference() {
				translate([20, 11.88, -h/2+5]) cube([18, 8, 10], center=true);
				translate([30, 12, -h/2+5])
					cylinder(r=3, h=20, center=true);
			}
		}
		translate([19-9.5/2, 12, -h/2+6]) rotate([90])
			cylinder(r=1.1, h=11, center=true, $fn=12);
		translate([19+9.5/2, 12, -h/2+6]) rotate([90])
			cylinder(r=1.1, h=11, center=true, $fn=12);
		translate([0, 8, 0]) rotate([angle])
			cylinder(r=4, h=40, center=true);
		for (z = [-7, 7]) {
			translate([0, 0, z]) screws();
		}
	}
}

translate([0, 0, h/2]) idler_end();
