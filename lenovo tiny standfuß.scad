/*

    lenovo tiny m700 standfuß

    doppelmitbogen(): zwei Füße mit Verbindungsbogen
                                 längere Druckzeit!   
                                 30% Füllung, Treesupport, 0,2 mm Schichtdicke
                                 --> 12 Stunden

    einzelfuss(): nur ein Fuß, zwei Mal drucken
                       --> 4 1/2 Stunden/Stück

*/

$fn = $preview ? 20 : 120; // hier ändern für schnelleres Rendern

fussbreite = 30.0;
fussabstand = 160;          // Aussenmaß

standbreite = 30.0;
standhoehe = 70.0;
standofs = 20.0;

// tiny
tinyb = 36.0;
tinyh = 185.0;
tinyl = 180.0;

//color("black") translate([-tinyb/2.0,0,10]) cube([tinyb,tinyh,tinyl]);

doppelmitbogen();

module einzelfuss() { 
    difference() {
        union() {
            intersection() {
                union() {
                    rotate([-90,0,0]) cylinder(h=fussbreite,d=80);
                }
                union() {
                    translate([-50,-50,0]) cube([500,500,200]);
                }
            }
            translate([standofs,standbreite/2.0,0]) cylinder(d=standbreite,h=standhoehe);
            translate([-standofs,standbreite/2.0,0]) cylinder(d=standbreite,h=standhoehe);
        }
        union() {
            color("black") translate([-tinyb/2.0,0,10]) cube([tinyb,tinyh,tinyl]);
        }
    }
}

module doppelmitbogen() {
    intersection() {
        union() {
            einzelfuss();
            translate([0,fussabstand-standbreite,0]) einzelfuss();

            translate([30,fussabstand/2.0,-120]) rotate([0,-90,0])
            difference() {
              cylinder(d=300,h=10);
              cylinder(d=280,h=10);
            }

            translate([-20,fussabstand/2.0,-120]) rotate([0,-90,0])
            difference() {
                  cylinder(d=300,h=10);
                  cylinder(d=280,h=10);
            }
        }
        union() {
            translate([-fussbreite*4,0,0]) cube([fussbreite*8,fussabstand,200]);
        }
    }
}