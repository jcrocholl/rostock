offset = 12;
wall = 1.6;

diameter1 = 10; // dial indicator
diameter2 = 9; // ball point pen

module penholder() {
  difference() {
    union() {
      translate([0, 0, 6])
        cube([2*wall+2, 2*offset+30, 20], center=true);
      translate([0, offset, 6])
        cylinder(r=diameter1/2+wall, h=20, center=true);
      translate([0, -offset, 6])
        cylinder(r=diameter2/2+wall, h=20, center=true);
      intersection() {
        union() {
          cylinder(r=29, h=8, center=true);
          translate([0, 0, 9])
            cylinder(r1=20, r2=3, h=14, center=true);
        }
        union() {
          rotate([0, 0, 30]) cube([100, 10, 100], center=true);
          rotate([0, 0, -30]) cube([100, 10, 100], center=true);
        }
      }
    }
    translate([0, offset, 0]) {
      cylinder(r=diameter1/2, h=100, center=true, $fn=24);
      translate([0, 10, 0]) cube([2, 20, 100], center=true);
    }
    translate([0, -offset, 0]) {
      cylinder(r=diameter2/2, h=100, center=true, $fn=24);
      translate([0, -10, 0]) cube([2, 20, 100], center=true);
    }
    for (a = [-30, 30, -150, 150]) {
      rotate([0, 0, a]) {
        translate([25, 0, 0]) {
          cylinder(r=2.2, h=10, center=true, $fn=12);
          translate([3, 0, 0]) cube([6, 1, 10], center=true);
        }
      }
    }
  }
}

translate([0, 0, 4]) penholder();

use <platform.scad>;
% translate([0, 0, -4]) platform();
