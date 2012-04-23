radius = 175; // pretty close to 150/cos(30)
radius2 = radius/cos(30);
radius3 = radius2/cos(30)/2;
radius4 = radius3*0.37;
h=4;

module jig() {
  difference() {
    union() {
      difference() {
	intersection() {
	  rotate([0, 0, 30])
	    cylinder(r=radius3, h=h, center=true, $fn=3);
	  cube([radius, 300, 20], center=true);
	}
	intersection() {
	  rotate([0, 0, 30]) translate([0, 0, 1])
	    cylinder(r=radius3*0.93, h=h, center=true, $fn=3);
	  cube([radius*0.95, 300, 20], center=true);
	}
	for (a = [0:120:360]) {
	  intersection() {
	    rotate([0, 0, a+30]) translate([radius3*0.44, 0, 0])
	      cylinder(r=radius4, h=h+1, center=true, $fn=3);
	    cube([radius*0.88, 300, 20], center=true);
	  }
	}
	rotate([0, 0, -30])
	  cylinder(r=radius4, h=h+1, center=true, $fn=3);
      }
      translate([0, -25.5, 0.5-h/2]) rotate([0, 0, 45])
	cube([12, 12, 1], center=true);
      translate([-30, radius3/2-8, 0])
	cylinder(r=8, h=h, center=true, $fn=12);
      translate([30, radius3/2-8, 0])
	cylinder(r=8, h=h, center=true, $fn=12);
      translate([0, -radius3, 0])
	cylinder(r=8, h=h, center=true, $fn=12);
      translate([0, 8-radius3, 0])
	cube([16, 16, h], center=true);
    }
    translate([-30, radius3/2-8, 0])
      # cylinder(r=2.2, h=50, center=true, $fn=12);
    translate([30, radius3/2-8, 0])
      # cylinder(r=2.2, h=50, center=true, $fn=12);
    translate([0, -radius3, 0])
      # cylinder(r=2.2, h=50, center=true, $fn=12);
  }
}

translate([0, 0, h/2]) jig();
