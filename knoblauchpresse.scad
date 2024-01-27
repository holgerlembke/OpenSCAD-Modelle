/*

  Knoblauchpresse
  (Rotella-Remix)
  
*/


$fn = $preview ? 20 : 200;   // hier ändern für schnelleres Rendern


durchmesser = 65.0;
bodendicke = 10.0;
bodenrandhoehe = 7.0;
randdicke = 5.0;

blockhoehe = 45.0;
blockbreite = 30.0;

gelenkzapfenbreite = durchmesser/3.0;
gelenkzapfendurchmesser = 8.0;
gelenkzapfenpassung = 0.2;

deckeldicke = 12.0;

// funktioniert nicht, dann ist die Schneidtiefe nicht gegeben
messerlochdurchmesser = 7.0;
messerabstand = 5.8;
messerdicke = 0.6;

// Das Bodenraster
brd = 3;
brh = 40;

// der Abstand
rotelladicke = 9.0;

/** /
intersection() {
    union() {
        boden();
        deckel();
    }
    union() {
        translate([-50,0,-20]) cube([100,100,100]);
    }
}
/**/
boden();
deckel();
/**/

//==============================================================================================
// die Schneide+symboolische Gelenkachse
module deckel() {
    color("white") {
        difference() {
            union(){
                bh = blockhoehe-bodendicke-rotelladicke;
                translate([0,0,bodendicke+rotelladicke])
                cylinder(d=durchmesser,h=bh);
/*                
                d=gelenkzapfenbreite-gelenkzapfenpassung;
                translate([-d/2.0,0,bodendicke+rotelladicke])
                cube([d,durchmesser/2.0+blockbreite,blockhoehe-bodendicke-rotelladicke]);
*/                
                dz=gelenkzapfenbreite-gelenkzapfenpassung;
                translate([-dz/2.0,durchmesser/2.0+bh/2,bodendicke+rotelladicke+bh/2.0])
                rotate([0,90,0])
                cylinder(d=bh,h=dz);

                translate([-dz/2.0,bh/2,bodendicke+rotelladicke])
                cube([dz,durchmesser/2.0,blockhoehe-bodendicke-rotelladicke]);
                
                translate([0,0,bodendicke+3])
                cylinder(d=durchmesser-2.0,h=bodenrandhoehe);
            }
            union() {                
                gelenkloch();
            }
        }
    }
}

//==============================================================================================
// Boden
module boden() {
    color("lightblue") {
        difference() {
            union() {
                cylinder(d=durchmesser,h=bodendicke);
                cylinder(d=durchmesser+randdicke,h=bodendicke+bodenrandhoehe);

                translate([-durchmesser/2.0,0,0])
                cube([durchmesser,durchmesser/2.0+blockbreite,blockhoehe-blockbreite/2.0]);
    
                // Die Oberseite des Gelenks
                rotate([0,90,0])
                translate([-blockhoehe+blockbreite/2.0,durchmesser/2.0+blockbreite/2.0,-durchmesser/2.0])
                cylinder(d=blockbreite,h=durchmesser);
            }
            
            union() {
                // Die Senkung in der Bodenplatte
                translate([0,0,bodendicke])
                cylinder(d=durchmesser,h=bodenrandhoehe);

                // Freischneider des Bauraums
                translate([-durchmesser/2.0,0,bodendicke+bodenrandhoehe])
                cube([durchmesser,durchmesser/2.0,blockhoehe]);

                // der Schlitz im Block
                translate([-gelenkzapfenbreite/2.0,0,bodendicke+bodenrandhoehe])
                cube([gelenkzapfenbreite,durchmesser,blockhoehe]);
                
                // Halteraster 
                for (a =[-5:1:5]) {
                    translate([-brh/2.0,a*(brd+0.1),bodendicke])
                    rotate([0,90,0]) {
                        cylinder(d=brd,h=brh);
                        sphere(d=brd);
                        translate([0,0,brh]) sphere(d=brd);
                    }
                }

                gelenkloch();
            }
        }
    }
}

//==============================================================================================
module gelenkloch() {
    // das Loch für den Gelenkzapfen
    rotate([0,90,0])
    translate([-blockhoehe+blockbreite/2.0,durchmesser/2.0+blockbreite/2.0,-durchmesser/2.0])
    cylinder(d=gelenkzapfendurchmesser,h=durchmesser);
}


