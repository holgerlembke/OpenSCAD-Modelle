/*
   
   Eismann Füllstandsminderer
   
   
*/

$fn = $preview ? 20 : 300;



d1 = 55.0;                            // große Rundung 

x = 185.0;                            // Breite
y = 100.0;                            // Länge
z = 2.6;                                // PPlattformdicke 

zs = 40.0;                             // Steghöhe/Bodenabstand

rnd = 1.5;                             // Randstärke

// Körper
difference() {
    union() {
        color("red") {
            translate([-x/2+d1/2,0,0]) cylinder(d=d1,h=z);
            translate([x/2-d1/2,0,0]) cylinder(d=d1,h=z);
        }

        color("green") {
            translate([-x/2,0,0]) cube([x,y-d1/2,z]);
            translate([-x/2+d1/2,-d1/2,0]) cube([x-d1,y-d1/2,z]);
        }

        color("blue") {
            translate([-2.5-60+2.5,-d1/2+5,z]) cube([3,y-10,zs]);
            translate([-2.5+60-0.5,-d1/2+5,z]) cube([3,y-10,zs]);
        }
    }
    union() {
        translate([0,0,-1]) {
            for (i = [-10:10]) { 
                for (j = [-5:7]) { 
                    translate([ 11*i+(j % 2)*7+1,
                                    11*j+6,0]) cylinder(d=10,h=z+1);
                }
            }
        }
    }
}

// Rand
difference() {
    union() {
        color("red") {
            translate([-x/2+d1/2,0,0]) cylinder(d=d1,h=z);
            translate([x/2-d1/2,0,0]) cylinder(d=d1,h=z);
        }

        color("green") {
            translate([-x/2,0,0]) cube([x,y-d1/2,z]);
            translate([-x/2+d1/2,-d1/2,0]) cube([x-d1,y-d1/2,z]);
        }
    }
    union() {
        color("green") {
            translate([-x/2+rnd,rnd,0]) cube([x-rnd*2,y-d1/2-rnd*2,z]);
            translate([-x/2+d1/2+rnd,-d1/2+rnd,0]) cube([x-d1-rnd*2,y-d1/2-rnd*2,z]);
        }

        color("red") {
            translate([-x/2+d1/2,0,0]) cylinder(d=d1-rnd*2,h=z);
            translate([x/2-d1/2,0,0]) cylinder(d=d1-rnd*2,h=z);
        }
    }   
}

