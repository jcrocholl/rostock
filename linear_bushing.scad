module linear_bushing(inside_diameter, inside_factor, outside_diameter,
					  height, sides, angle, wall) {
	intersection() {
		union() {
			difference() {
				cylinder(r=outside_diameter/2, h=height,
						 center=true, $fn=sides*2);
				cylinder(r=outside_diameter/2-wall, h=height+1,
						 center=true, $fn=sides*2);
			}
			for (side = [1 : sides]) {
				rotate([0, 0, 360 * side / sides]) {
					translate([outside_diameter/2, 0, 0])
						rotate([0, 0, angle])
						cube([(outside_diameter-inside_diameter*inside_factor)
							  /cos(angle), wall, height], center=true);
				}
			}
		}
		cylinder(r=outside_diameter/2, h=height, center=true, $fn=sides*2);
	}
}

// This will produce a test grid for wall thickness and inside_factor, then
// you can try which size fits best for your printer and slicer settings.

for (x = [0 : 0]) {
	translate([20*x, 0, 0]) {
		linear_bushing(inside_diameter=8, inside_factor=0.975+0.005*x,
					   outside_diameter=15,
					   height=24, sides=16, angle=20, wall=0.9);
	}
}
