/*
        Sodastream Wandhalter
        
        2025-01-26
*/

$fn = $preview ? 20 : 200;


wandstaerke = 3.4;
abstand = 55.0+9.0;     // Abstand oben/unten

// Ring unten
ruda = 49.0;     // Durchmesser aussen
rudi = 40.0;      // .. innen
keilub = 8.0;   // Keil Größe 

// Ring oben
roda = 100.0;    // Durchmesser aussen
rodi2 = 77.0;    // Durchmesser innen Zylinder oben
rodi1 = 74.0;   // ... innen ... unten
keilob = 12.0;   // Keil Größe 

keilsi = (roda-ruda)/2.0;

einzelhalter();
translate([roda,0,0]) einzelhalter();


//===============================================================
module einzelhalter() {
    intersection() {
        union() {
            // oberer Ring
            translate([0,0,abstand]) difference() {
                union() {
                    cylinder(d = roda, h = wandstaerke);
                    translate([-roda/2,0,0]) cube([roda,roda/2,wandstaerke]);
                }
                union() {
                    cylinder(d1 = rodi1, d2 = rodi2, h = wandstaerke);
                    
                    keils1 = [[0,0],[0,keilsi],[keilsi,0]];
                    color("gray") {
                        translate([-roda/2,roda/2,0]) 
                        rotate([0,0,-90])
                        linear_extrude(height=wandstaerke) polygon(keils1);

                        translate([+roda/2,roda/2,0]) 
                        rotate([0,0,180])
                        linear_extrude(height=wandstaerke) polygon(keils1);
                    }
                }
            }

            // unterer Ring
            difference() {
                union() {
                    cylinder(d = ruda, h = wandstaerke);
                    translate([-ruda/2,0,0]) cube([ruda,roda/2.0,wandstaerke]);
                }
                union() {
                    cylinder(d = rudi,  h = wandstaerke);
                }
            }
            
            translate([-ruda/2,roda/2-wandstaerke,0]) 
                cube([ruda,wandstaerke,abstand+wandstaerke]);
            
            // Keil unten
            keil1 = [[0,0],[0,keilub],[keilub,0]];
            
            color("red") {
                translate([ruda/2,roda/2-wandstaerke,wandstaerke]) rotate([90,0,-90])
                linear_extrude(height=wandstaerke) polygon(keil1);
                translate([-ruda/2+wandstaerke,roda/2-wandstaerke,wandstaerke]) rotate([90,0,-90])
                linear_extrude(height=wandstaerke) polygon(keil1);
            }
            
            // Keil oben
            keil2 = [[0,0],[0,keilob],[keilob,0]];
            
            color("blue") {
                translate([ruda/2,roda/2-wandstaerke,abstand]) rotate([90,90,-90])
                linear_extrude(height=wandstaerke) polygon(keil2);
                translate([-ruda/2+wandstaerke,roda/2-wandstaerke,abstand]) rotate([90,90,-90])
                linear_extrude(height=wandstaerke) polygon(keil2);
            }
        }
        union() {
            // für den vorderen Anschnitt
            translate([-roda/2,-roda/2+5,0]) 
                cube([roda,roda,100]);
        }
    }
}







