module clamp(h, base){
  difference(){
    union() {
      // Clamp cone for M8 nut.
      cylinder(r1=4.5, r2=3.5, h=h);
      // Gradual cone base.
      translate([0, 0, base]) cylinder(r1=10, r2=0, h=12, center=true);
      // Base middle.
      translate([0, 0, base/2]) {
	cylinder(r=11, h=base, center=true);
	cube([46, 12, base], center=true);
      }
      // Shoulders around screw holes.
      for (x = [-23, 23]) {
	translate([x, 0, base/2]) cylinder(r=6, h=base, center=true);
      }
    }
    // Bowden cable through hole.
    cylinder(r=2, h=30, $fn=12);
    // Three sided cutout.
    for (a = [0:120:359]) {
      rotate([0, 0, a]) translate([3, 0, base+1+h/2])
	cube([5, 1, h], center=true);
    }
    // Holder for PEEK insulator (e.g. MakerGear GrooveMount).
    cylinder(r=8.2, h=10, center=true);
    // Nut traps and screw holes.
    for (x = [-25, 25]) {
      translate([x, 0, base/2]) {
	cylinder(r = 2.2, h=base+1, center=true, $fn=12);
	rotate([0, 0, 0]) cylinder(r=4.1, h=base, $fn=6);
      }
      translate([x*1.2, 0, base]) cube([6, 20, base], center=true);
    }
  }
}

height = 24;
clamp(height, 8);

// Increase cooling time per layer for the thin riser.
translate([0, -20, height/2]) cube([60, 3, height], center=true);
