$fa = 3;
$fs = 0.1;

aluminum = [0.9, 0.9, 0.9];
polycarbonate = [0.3, 0.3, 0.3];
brass = [0.8, 0.7, 0];

module pulley(bore_diameter, outside_diameter, width,
        flange_diameter, flange_width,
        hub_diameter, hub_width) {
  color(polycarbonate)
  difference() {
    union() {
      difference() {
        union() {
          cylinder(r=outside_diameter/2, h=width+2*flange_width,
               center=true);
          // Flanges
          translate([0, 0, (width+flange_width)/2])
            cylinder(r=flange_diameter/2, h=flange_width,
                 center=true);
          translate([0, 0, -(width+flange_width)/2])
            cylinder(r=flange_diameter/2, h=flange_width,
                 center=true);
          // Brass insert
          color(brass)
            translate([0, 0, (hub_width-width-2*flange_width)/2])
            cylinder(r=hub_diameter/3, h=hub_width+0.1,
                 center=true);
        }
        // Side groove
        translate([0, 0, width/3])
          cylinder(r=outside_diameter/3, h=width, center=true);
      }
      // Hub
      translate([0, 0, (hub_width-width-2*flange_width)/2])
         cylinder(r=hub_diameter/2, h=hub_width, center=true);
    }
    // Bore
    color(brass)
      cylinder(r=bore_diameter/2, h=2*hub_width, center=true);
  }
}

translate([10, 0, 0]) rotate([90, 0, 0])
  pulley(6, 38.8, 7, 42, 1, 17, 17);

module narrow_pulley(bore_diameter, outside_diameter, width,
           flange_diameter, flange_width,
           hub_diameter, hub_width) {
  color(aluminum)
  difference() {
    union() {
      cylinder(r=outside_diameter/2, h=width+2*flange_width,
           center=true);
      // Flanges
      translate([0, 0, (width+flange_width)/2])
        cylinder(r=flange_diameter/2, h=flange_width, center=true);
      translate([0, 0, -(width+flange_width)/2])
        cylinder(r=flange_diameter/2, h=flange_width, center=true);
      translate([0, 0, 0.75*flange_width-hub_width/2])
        cylinder(r=hub_diameter/2,
             h=hub_width-width-1.5*flange_width,
             center=true);
    }
    // Bore
    cylinder(r=bore_diameter/2, h=2*hub_width, center=true);
  }
}

translate([-25, 0, 0]) rotate([270, 0, 0])
narrow_pulley(5, 9.7, 7, 15, 1, 14.7, 14.3);
