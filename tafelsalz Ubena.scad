/*

    Tafelsalz - ein Ubena-Deckel
   
*/

$fn = $preview ? 40 : 120; // hier ändern für schnelleres Rendern

do = 39.0;
di = 36.0;
dii = 34.0;
ho = 13.3;
dd = ho - 12.7;

rih = 1.5;                   // Innenrand Höhe
zapfb = 2.0;
zapfd = 1.0;
zapfh = 2.5;

k = 16;

p = [[0,0.8],[0,1.2],[1,2],[1,0]];

// Aussenform
difference() {
    union() {
        cylinder(d = do, h=ho, $fn=16);

        // Deckel aussenrand
        translate([0,0,-0.5])
        cylinder(d = do-0.5, h=0.5, $fn=16);
    }
    union() {
        translate([0,0,dd+rih])
        cylinder(d = di, h=ho+dd);

        translate([0,0,dd])
        cylinder(d = dii, h=rih);

        translate([0,0,ho-0.5])
        cylinder(d = di+0.8, h=rih);
    }
}

// Einbauteile
rotate([0,0,360/k/2.0])
for (a =[0:3]) {
    union() {
        rotate([0,0,90*a])
        translate([-zapfb/2.0,(dii-0.1)/2.0,dd+rih])
        cube([zapfb,zapfd,zapfh]);
        
        rotate([0,0,90*a]) {
            // Das fast waagerechte Stück
            rotate([2,0,-2])
            translate([-0.5,0,4])
            rotate_extrude(angle = 30, convexity = 10)
            translate([(di-1)/2.0, 0, 0])
            polygon(p);

            // Das schräge Stück. Lösung ist auch schräg.
            scale=2.0;
            stepend = 40;
            for (b=[0:stepend]) {
                rotate([3,0,28.7+b/scale])
                translate([-0.48+0.6/((stepend+1)-b),0.3,4.5+b/scale/4.0])
                rotate([40,0,0])
                rotate_extrude(angle = 2, convexity = 10)
                translate([(di-1)/2.0, 0, 0])
                polygon(p);
            }
        }
    }
}














