include <configuration.scad>;
use <belt.scad>;
use <bearing.scad>;
use <nema.scad>;
use <motor_end.scad>;
use <idler_end.scad>;
use <carriage.scad>;
use <platform.scad>;
use <rod.scad>;

aluminum = [0.9, 0.9, 0.9];
steel = [0.8, 0.8, 0.9];
use_stls=false;

//build radius for animation.
br=50;

platformxyz=[cos($t*360)*br,sin($t*360)*br,30];

belt_length=smooth_rod_length-motor_end_height/2-idler_end_height/2;

module smooth_rod() 
{
	color(steel) cylinder(r=4, h=smooth_rod_length);
}

module tower(height) 
{
	translate([0, tower_radius, 0]) 
	{
		translate([0, 0, motor_end_height]) 
		rotate([180,0,0])
		if (use_stls) import ("motor_end.stl"); else render() motor_end();

		translate([0, 0, smooth_rod_length-idler_end_height]) 
		rotate(180)
		if (use_stls) import ("idler_end.stl"); else idler_end();

		translate([30, 0, 0]) smooth_rod();
		translate([-30, 0, 0]) smooth_rod();

		translate([0, 0, motor_end_height+bed_thickness+pcb_thickness+8+platformxyz[2]+height]) 
		rotate([0, 180, 0]) 
		{
			if (use_stls) import ("carriage.stl"); else render() carriage();
			for(j=[-30,30])
			translate([j,0,0])
			lm8uu();
		}

		translate([0, 17-10, motor_end_height/2]) nema17(47);

		// Ball bearings for timing belt
		translate([0,-4, smooth_rod_length-28/2]) 
		bearing(8, 22, 7);

		// Timing belt
		translate([-22/2,-4+7/2, belt_length/2+motor_end_height/2]) 
		rotate([0, 90, 0]) 
		timing_belt(belt_length);

		translate([22/2,-4+7/2, belt_length/2+motor_end_height/2]) 
		rotate([0, 90, 0]) 
		timing_belt(belt_length);
	}
}

module rod_pair(lean_y,lean_x)
{
	for(i=[-1,1])
	translate([25*i,platform_hinge_offset,0])
	rotate([lean_x,0,0])
	rotate([0,lean_y,0])
	rotate([0, -90, 0]) 
	if (use_stls) import ("rod.stl"); else 
	rod(rod_length);
}

module rostock() 
{
	for(i=[0:2])
	assign(angle=120*i)
	assign(carriage_xy=[0,tower_radius-carriage_hinge_offset],
		platform_xy=[platformxyz[0]*cos(angle)+platformxyz[1]*sin(angle),
		platformxyz[1]*cos(angle)-platformxyz[0]*sin(angle)+
		platform_hinge_offset])
	assign(rod_dist=carriage_xy-platform_xy)
	assign(dist=sqrt(rod_dist[0]*rod_dist[0]+rod_dist[1]*rod_dist[1]))
	assign (height=sqrt(rod_length*rod_length-dist*dist))
	assign(lean_y=90-acos(rod_dist[0]/rod_length),
		 lean_x=-atan2(rod_dist[1],height))
	{
		rotate(angle)
		tower(height);

		translate(platformxyz)
		rotate(angle)
		translate([0,0,motor_end_height+bed_thickness+pcb_thickness+
			platform_thickness/2])
		rod_pair(lean_y,lean_x);
	}

	translate(platformxyz) 
	translate([0, 0, motor_end_height+bed_thickness+pcb_thickness]) 
	rotate([0, 0, 60]) 
	if (use_stls) import ("platform.stl"); else platform();

	% translate([0, 0, motor_end_height+bed_thickness/2])
	cylinder(r=(tower_radius-8/2)/cos(30), h=bed_thickness, center=true, $fn=6);

	color([0.9, 0, 0]) 
	translate([0, 0, motor_end_height+bed_thickness+pcb_thickness/2])
	cube([tower_radius*1.4, tower_radius*1.4, pcb_thickness], center=true);
}

rostock();