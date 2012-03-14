use <carriage.scad>;


cutout = 12.5;
inset = 6;
radius = width/2 - inset;
radius2 = width/2 - 4;

difference() {
	union() {
		for (a = [0, 120, 240]) {
			rotate([0, 0, a]) {
				translate([0, -32, 0]) parallel_joints();
				translate([0, 20, 0]) cylinder(r=8, h=8, center=true);
			}
		}
		cylinder(r=26, h=8, center=true);
	}
	cylinder(r=18, h=20, center=true);
	for (a = [0 : 60 : 359]) {
		rotate([0, 0, a]) {
			translate([0, -22, 0]) cylinder(r=2, h=9, center=true, $fn=12);
		}
	}
}
