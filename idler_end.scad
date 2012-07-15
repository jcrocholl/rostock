include <configuration.scad>
use <bracket.scad>

h = idler_end_height; // Total height.
tilt = 2; // Tilt bearings upward (the timing belt is pulling pretty hard).

module bearing_mount() {
  translate([0, 0, 2.3]) cylinder(r1=12, r2=9, h=1.1, center=true);
  translate([0, 0, -2.3]) cylinder(r1=9, r2=12, h=1.1, center=true);
}

x = 17.7; // Micro switch center.
y = 16; // Micro switch center.

module idler_end() {
  translate([0, 0, h/2]) 
  difference() {
    union() {
      bracket(h);
      translate([0, 7.5, 0]) rotate([90 - tilt, 0, 0]) bearing_mount();
      // Micro switch placeholder.
      % translate([x, y, -h/2+4]) rotate([0, 0, 15])
          cube([19.6, 6.34, 10.2], center=true);
      difference() {
        translate([20, 11.88, -h/2+5])
          cube([18, 8, 10], center=true);
        translate([x, y, -h/2+4]) rotate([0, 0, 15])
          cube([30, 6.34, 20], center=true);
        translate([30, 12, -h/2+5])
          cylinder(r=3, h=20, center=true);
      }
    }
    translate([x, y, -h/2+6]) rotate([0, 0, 15]) {
      translate([-9.5/2, 0, 0]) rotate([90, 0, 0])
	cylinder(r=1.1, h=26, center=true, $fn=12);
      translate([9.5/2, 0, 0]) rotate([90, 0, 0])
	cylinder(r=1.1, h=26, center=true, $fn=12);
    }
    translate([0, 8, 0]) rotate([90 - tilt, 0, 0])
      cylinder(r=4, h=40, center=true);
    for (z = [-7, 7]) {
      translate([0, 0, z]) screws();
    }
  }
}

idler_end();
