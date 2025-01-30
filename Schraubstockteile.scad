/*
        Schraubstockteile

        * einzeln nach stl expoertieren, damit Höhenausrichtung stimmt
        * Klemmbacke zwei Mal zum Druck hinzufügen, flache Seite oben
        * Parallelführer jeweils seitlich ein mal abschmirgeln
        * Parallelführer benötigt M4 Schrauben M4x12 oder so
        
        2025-01-23/28        
*/

$fn = $preview ? 20 : 200;

// drehknopf();
// klemmbacke();
parallelfuehrer();

//*****************************************************************************************************
module parallelfuehrer() {
    /*
        Der Block kann nicht an die Längsanschläge anschlagen,
        da dort eine Gußrundung ist. Darum insgesamt kürzer.
    */
    lochabstand = (25.5+34.6)/2.0;
    lochofset = 12.5;    // Kürzer
    schrlochdm = 4.6;
    
    // der Schraubenrand
    schradm = 12.0;
    schrahdelta = 4.5;    // Ringhöhe wg. Schraubenlänge
    
    blockbreite = 66.6;
    blocklaenge = 36.0;
    blockhoehe = 6.0;
    blockofs = 5.0;
    blockseitenhoehe = 15.0;    
    blockseitenbreite = 10.0;
    bockseitenfase = 2.5;
    bockrandfase = 2.5;
    
    difference() {
        union() {
            color("gray")
            translate([-blockbreite/2+blockofs,0,0])
                cube([blockbreite-2*blockofs,blocklaenge,blockhoehe]); 

            color("cyan") {
                translate([-blockbreite/2,0,0])
                    blockfase(blockseitenbreite,blocklaenge,blockseitenhoehe,bockseitenfase,bockrandfase); 
                translate([blockbreite/2-blockseitenbreite,0,0])
                    blockfase(blockseitenbreite,blocklaenge,blockseitenhoehe,bockseitenfase,bockrandfase); 
            }
            // Die Schraubenabstandhalter wg. passende Schraube nicht in Grabbelkiste
            color("green") {
                translate([-lochabstand/2.0,lochofset,0])
                    cylinder(d=schradm, h=blockhoehe+schrahdelta);
                translate([lochabstand/2.0,lochofset,0])
                    cylinder(d=schradm, h=blockhoehe+schrahdelta);
            }
        }
        union() {
            color("red") {
                translate([-lochabstand/2.0,lochofset,-20])
                    cylinder(d=schrlochdm, h=100);
                translate([lochabstand/2.0,lochofset,-20])
                    cylinder(d=schrlochdm, h=100);
            }
        }
    }
}

//*****************************************************************************************************
module blockfase(x,y,z,f1,f2) {
    p1 = [[f1,0],[0,f1],[0,z],[x,z],[x,f1],[x-f1,0]];
    p2 = [[0+f2,0],[0,0+f2],[0,y-f2],[0+f2,y],[x-f2,y],[x,y-f2],[x,f2],[x-f2,0]];
    intersection() {
        translate([0,y,0]) 
            rotate([90,0,0]) 
                linear_extrude(height=y) polygon(p1);

        linear_extrude(height=z) polygon(p2);
   }            
}


//*****************************************************************************************************
module drehknopf() {
    aussendm = 40;
    rundung = 10;
    hoehe = 25.0;
    bohrungsdm = 12.2;
    schmeichler = 3;        // Nuttiefe am Drehknopf. Kleiner ist tiefer.
    
    difference() {
        union() {
            // Randrundung unten
            color("green")
            rotate_extrude(convexity=10) 
                translate([aussendm/2-rundung/2, 0, 0]) 
                    circle(d=rundung);
            // Randrundung oben
            color("blue")
            translate([0,0,hoehe-rundung/2])
            rotate_extrude(convexity=10) 
                translate([aussendm/2-rundung/2, 0, 0]) 
                    circle(d=rundung);
            // Innenteile I
            color("gray")
            translate([0,0,0]) 
                cylinder(d=aussendm,h=hoehe-rundung/2);
            // Innenteile II
            color("white")
            translate([0,0,-rundung/2]) 
                cylinder(d=aussendm-rundung,h=hoehe+rundung/2);
            
        }
        union() {
            // die Bohrung, ohne Gewinde
            cylinder(d=bohrungsdm,h=100);
            
            // die Handschmeichler
            color("red")
            for (x=[0:6]) {
                rotate([0,0,x*60])
                    translate([aussendm/2+rundung/2+schmeichler,0,-20])
                        cylinder(d=20,h=100);
            }
        }
    }
}


//*****************************************************************************************************
module klemmbacke() {
    backenbreite = 71.0;
    backenhoehe = 26.0;
    backenrand = 2.0;
    backentiefe = 4.0; // nach hinten

    klemmhoehe = 2.0;
    klemmbreite = 2.0;  // Breite des Schlitzes für die PCB

    difference() {
        // daten für Diagonalschnitt 45°
        delta45 = klemmbreite*sqrt(2)/2;
        ofs45 = -8;
        // daten für Diagonalschnitt 30°
        delta30s = klemmbreite*sin(30);
        delta30c = klemmbreite*cos(30);
        ofs30y = -2;
        ofs30x = -10;
        
        union() {
            color("blue") // der Körper um die Backen
                translate([0,0,-backentiefe]) cube([backenbreite+2*backenrand,backenhoehe+backenrand,backentiefe]);
            
            // die Dickschicht für die Klemmnuten
            cube([backenbreite+2*backenrand,backenhoehe+backenrand,klemmhoehe]);
        }
        union() {
            color("red") // die Aussparung für die Backen
                translate([backenrand,0,-backentiefe-backenrand]) cube([backenbreite,backenhoehe,backentiefe]);

            color("green") {
                // mittelachsmarkierung
                translate([(backenbreite+2*backenrand)/2.0,-10,klemmhoehe]) 
                    rotate([-90,0,0]) cylinder(d=1,h=50);
                // obere Kante
                translate([0,backenhoehe,klemmhoehe]) 
                    rotate([-90,0,-90]) cylinder(d=1,h=250);
            }

            // oberste Kante
            translate([0,backenhoehe+backenrand-klemmbreite,0]) cube([backenbreite+2*backenrand,klemmbreite,klemmhoehe]);
            // Kante da drunter
            translate([0,backenhoehe+backenrand-klemmbreite-10,0]) cube([backenbreite+2*backenrand,klemmbreite,klemmhoehe]);
            
            // Diagonalschnitte I
            translate([+delta45,+ofs45,0]) rotate([0,0,45]) cube([backenbreite+2*backenrand,klemmbreite,klemmhoehe]);        
            translate([backenbreite+2*backenrand,delta45+ofs45,0]) rotate([0,0,180-45]) cube([backenbreite+2*backenrand,klemmbreite,klemmhoehe]);        

            // Diagonalschnitte II
            translate([delta30s-ofs30x,ofs30y,0]) rotate([0,0,30]) cube([backenbreite+2*backenrand,klemmbreite,klemmhoehe]);        
            translate([backenbreite+2*backenrand+ofs30x,delta30c+ofs30y,0]) rotate([0,0,180-30]) cube([backenbreite+2*backenrand,klemmbreite,klemmhoehe]);        
        }
    }
}