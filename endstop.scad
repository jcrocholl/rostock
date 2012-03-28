use <bracket.scad>;

h = 24; // Total height.
b = 8; // Bottom height (where the micro switch is attached).

module microswitch() {
	union() {
		translate([0, -3.5, 2.5]) cube([6.3, 19.66, 10.55], center=true);
		translate([0, 0, 8]) cube([3.5, 2, 3], center=true);
	}
}

x = -45 * cos(30);
y = 50 - 45 * sin(30);

% translate([30+x, y, 4]) rotate([0, 180, -30]) microswitch();

module endstop() {
	difference() {
		union() {
			translate([0, 0, -h/2]) intersection() {
				bracket(h);
				translate([30, 10, 0]) cube([12, 25, h], center=true);
			}
			translate([30, 16.3, -b/2]) cube([12, 19, b], center=true);
			translate([-x, y, -b/2]) rotate([0, 0, 30])
				translate([-3.15-5.35, -3.5, 0])
				cube([10.7, 19, b], center=true);
		}
		// M2.5x12 micro switch mounting screws.
		# translate([-x, y, -b/2]) rotate([0, 0, 30]) {
			translate([0, -3.5-9.5/2, 0]) rotate([0, 90])
				cylinder(r=1.1, h=26, center=true, $fn=12);
			translate([0, -3.5+9.5/2, 0]) rotate([0, 90])
				cylinder(r=1.1, h=26, center=true, $fn=12);
		}
		// Push-through hole for vertical M4 screw.
		translate([30, 12, -h/2])
			# cylinder(r=2.2, h=h+1, center=true, $fn=12);
	}
}

translate([30, 0, 0]) rotate([0, 180, 0]) endstop();

// use <platform.scad>;
// translate([30, 50, -16]) platform();
translate([30, 50, -16]) rotate([0, 0, 120]) translate([0, 45, 0])
% cylinder(r=1.5, h=20, center=true, $fn=12);

