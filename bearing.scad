steel = [0.8, 0.8, 0.9];

module bearing(id, od, w) {
    color(steel) rotate([90, 0, 0]) difference() {
		cylinder(h=w, r=od/2, center=true);
		cylinder(h=w*2, r=id/2, center=true);
    }
}

bearing(8, 22, 7); // 608 skateboard ball bearing.

module lm8uu() {
    color(steel) difference() {
        cylinder(h=25, r=7.5, center=true);
        cylinder(h=30, r=4, center=true);
    }
}

translate([30, 0, 0]) lm8uu(); // Linear bearing for 8mm smooth rod.
