$fa = 12;
$fs = 0.5;

w = 60; // Smooth rod distance (center to center)

module screws() {
  for (x = [-w/2, w/2]) {
    translate([x, 0, 0]) {
      // Push-through M3 screw hole.
      translate([0, -6, 0]) rotate([0, 90, 0])
	cylinder(r=1.65, h=20, center=true);
      // M3 nut holder.
      translate([-x/5, -6, 0])
	rotate([30, 0, 0]) rotate([0, 90, 0])
	cylinder(r=3.2, h=2.3, center=true, $fn=6);
    }
  }
}

module bracket(h) {
  difference() {
    union() {
      translate([0, -1, 0]) cube([w+12, 22, h], center=true);
      // Sandwich mount.
      translate([-w/2, 10, 0]) cylinder(r=6, h=h, center=true);
      translate([w/2, 10, 0]) cylinder(r=6, h=h, center=true);
    }
    // Sandwich mount.
    translate([-w/2, 12, 0]) cylinder(r=1.9, h=h+1, center=true);
    translate([w/2, 12, 0]) cylinder(r=1.9, h=h+1, center=true);
    // Smooth rod mounting slots.
    for (x = [-w/2, w/2]) {
      translate([x, 0, 0]) {
	cylinder(r=4.2, h=h+1, center=true);
	translate([0, -10, 0]) cube([2, 20, h+1], center=true);
      }
    }
    // Belt path.
    translate([0, -5, 0]) cube([w-20, 20, h+1], center=true);
    translate([0, -9, 0]) cube([w-12, 20, h+1], center=true);
    translate([-w/2+10, 1, 0]) cylinder(r=4, h=h+1, center=true);
    translate([w/2-10, 1, 0]) cylinder(r=4, h=h+1, center=true);
  }
}

translate([0, 0, 10]) bracket(20);
