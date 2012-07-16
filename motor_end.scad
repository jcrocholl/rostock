include <configuration.scad>
use <bracket.scad>

h = motor_end_height; // Total height.
m = 29; // Motor mounting screws distance (center to center)

module motor_end() {
    translate([0, 0, h/2]) 
    difference() {
    union() {
      bracket(h);
      for (x = [-30, 30]) {
        // Diagonal fins.
        translate([x, 29.5, 0]) intersection() {
          cube([5, 30, h], center=true);
          rotate([45, 0, 0]) translate([0, -50, 0])
            cube([20, 100, 100], center=true);
        }
        // Extra mounting screw holes.
        translate([x, 47, 4-h/2]) difference() {
          cylinder(r=5, h=8, center=true, $fn=24);
          translate([0, 1, 0]) cylinder(r=1.9, h=9, center=true, $fn=12);
        }
      }
    }
    // Motor shaft (RepRap logo)
    rotate([90, 0, 0]) cylinder(r=12, h=40, center=true);
    translate([0, 0, sin(45)*12]) rotate([0, 45, 0])
      cube([12, 40, 12], center=true);
    // Motor mounting screw slots
    translate([m/2, 0, m/2]) rotate([0, -45, 0])
      cube([9, 40, 3], center=true);
    translate([-m/2, 0, m/2]) rotate([0, 45, 0])
      cube([9, 40, 3], center=true);
    translate([m/2, 0, -m/2]) rotate([0, 45, 0])
      cube([9, 40, 3], center=true);
    translate([-m/2, 0, -m/2]) rotate([0, -45, 0])
      cube([9, 40, 3], center=true);
    for (z = [-14, 0, 14]) {
      translate([0, 0, z]) screws();
    }
  }
}

motor_end();
