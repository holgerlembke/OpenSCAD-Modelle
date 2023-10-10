/*

    3 x 8 Barke
   
*/

$fn = $preview ? 43 : 200; // hier ändern für schnelleres Rendern

// Stab/Barke
wands = 1.0;
dinnen = 15.1;
laenge = 58.0;

// Esp8266 wemos mini Gehäuse

daussen = 47.5;
hoehe = 16.0;

intersection() {
    union() {
        /**/
        // Barke
        color("red") {
            difference() {
                union() {
                    cylinder(h=laenge+wands,d=dinnen+2*wands);
                    cylinder(h=2,d=dinnen+2*wands+3);
                }
                union() {
                    cylinder(h=laenge,d=dinnen);
                }
            }
        }
        /**/

        /**/
        // Fuss
        translate([0,0,-14.5]) {
            color("green") {
                difference() {
                    union() {
                        cylinder(h=hoehe,d=daussen);
                    }
                    union() {
                        translate([0,0,-20]) cylinder(h=laenge+wands,d=dinnen+2*wands+0.2);
                        translate([0,0,-5]) cylinder(h=16,d=dinnen+2*wands+0.2+3);
                        
                        translate([-8.0,-13.5,0]) cube([16.0,27.0,14.0]);
                        translate([0,1.5,8]) rotate([90,0,0]) cylinder(d=3.0,h=30.0);
                    }
                }
            }
        }
        /**/
    }
    union() {
        /**/
        translate([0,0,-25]) cube([100,100,100]);
        /**/
        /**/
        translate([-50,-50,-25]) cube([100,100,100]);
        /**/
    }
}





