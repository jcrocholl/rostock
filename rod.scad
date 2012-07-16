include <configuration.scad>
use <jaws.scad>

l = rod_length;
h = 7;
r = h/2 / cos(30);

// Wipe nozzle after long travel moves.
module collar() {
  difference() {
    cube([4, 20, h], center=true);
    cube([2, 18, h+1], center=true);
    rotate([0, 90, 0]) rotate([0, 0, 30])
      cylinder(r=5, h=5, center=true, $fn=6);
  }
}

// Small hollow cube.
module cubicle() {
  difference() {
    cube([6, 6, h], center=true);
    cube([4, 4, h+1], center=true);
  }
}

// Nozzle wipers.
module wipers() {
  translate([l/2+2, 0, 0]) cubicle();
  translate([-l/2-2, 0, 0]) cubicle();
  translate([l/2-25, 0, 0]) collar();
  translate([-l/2+25, 0, 0]) collar();
}

// Rod with two Y shaped rod ends.
module rod(l) {
  translate([l/2,0,0])
  union() {
    translate([-l/2, 0, 0]) jaws();
    translate([l/2, 0, 0]) rotate([0, 0, 180]) jaws();
    rotate([0, 90, 0]) rotate([0, 0, 30])
      cylinder(r=r, h=l-18, center=true, $fn=6);
  }
}

module printable_rod(l)
{
	// Print platform.
	bed = 8*25.4; // 8x8 inches.
	% translate([0, 0, -1]) cube([bed, bed, 2], center=true);

	rotate(45)
	translate([-l/2,0,h/2])
	rod(l=l);

	// If your nozzle doesn't ooze at all, you can comment the next line out.
	translate([0,0,h/2])
	rotate(45)
	wipers();
}

rod(l=l);
//printable_rod(l=l);