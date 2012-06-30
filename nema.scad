use <pulley.scad>;

$fa = 3;   // Minimum angle for circle segments.
$fs = 0.5; // Minimum size for circle segments.

aluminum = [0.9, 0.9, 0.9];
steel = [0.8, 0.8, 0.9];

motor_screw = 15.5;
motor_diagonal = sqrt(2 * motor_screw * motor_screw);

module nema17(length) {
  color([0.4, 0.4, 0.4]) {
    translate([0, -length/2-17, 0])
      intersection() {
      cube([42, length, 42], center=true);
      rotate([0, 45, 0]) cube([53, length, 53], center=true);
    }
    translate([0, -17, 0]) rotate([90, 0, 0])
      cylinder(r=11, h=4, center=true);
  }
  color(steel)
  translate([0, -length/2-7, 0]) rotate([90, 0, 0])
    cylinder(r=2.5, h=length+21, center=true);
  for (a = [0, 90, 180, 270]) rotate([0, a, 0]) {
    color([0.2, 0.2, 0.2]) translate([motor_screw, 0, motor_screw])
      rotate([90, 0, 0]) {
      translate([0, 0, 10]) cylinder(r=2.5, h=4, center=true);
      translate([0, 0, 16]) cylinder(r=1.5, h=12, center=true);
    }
    color(steel) translate([motor_screw, -11.8, motor_screw])
      rotate([90, 0, 0]) cylinder(r=5, h=0.5, center=true);
  }
}

nema17(47);
