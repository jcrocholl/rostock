$fa = 0.5;
$fs = 0.5;

h = 3.5;

difference() {
	intersection() {
		cylinder(r1=15, r2=12, h=h, center=true);
		cylinder(r=14, h=h, center=true);
	}
	cylinder(r=10.8, h=h+1, center=true);
}
