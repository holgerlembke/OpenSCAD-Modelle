/*

    TP-Link HS100 Buttonpanel
   
*/

$fn = $preview ? 20 : 120; // hier ändern für schnelleres Rendern



ho = 5.5;
bb = 4.0;   // Bodenbreite
len = 35.0+5.0+2.0;
lend = 16.0;
backbr = 3.0;

intersection() {
    translate([-50,-0,-50]) cube([100,100,100]);
    difference() {
        union() {
            // Rahmen
            cube([len,bb,ho]);

            color("red") {
                translate([0,bb,0]) {
                    cube([backbr,10,ho]);
                    translate([len-backbr,0,0]) cube([backbr,10,ho]);
                }
            }    

            // Deckelplatte
            color("green") {
                translate([0,0,-4]) cube([len,15,4]);
            }    

            // Vorbau
            color("blue") {
                translate([lend/2.0,0,-4]) cube([len-lend,15,4]);
                translate([lend/2.0+26.0/2.0,12,-4]) cylinder(d=25,h=4);
            }
        }
        
        union() {
            // Loch für Taster
            color("gray") {
                tabr = 6.6;
                translate([len/2.0,14,-4-5]) {
                    translate([0,0,5+3]) cube([tabr,tabr,3.0],center=true);
                    cylinder(d=4.0,h=20);
                    
                    dx = 2.8;
                    dy = 3.0;
                    db = 2.2;
                    translate([dx,dy,-1]) cylinder(d=db,h=20);
                    translate([dx,-dy,-1]) cylinder(d=db,h=20);
                    translate([-dx,dy,-1]) cylinder(d=db,h=20);
                    translate([-dx,-dy,-1]) cylinder(d=db,h=20);
                }
            }
            // Loch für LED
            color("pink") {
                translate([len/2.0,20,-4-5]) {
                    cylinder(d=4.0,h=20);
                    
                    translate([0,0,7.5]) cylinder(d=5.0,h=4);
                }
            }
        }
    }
}

//