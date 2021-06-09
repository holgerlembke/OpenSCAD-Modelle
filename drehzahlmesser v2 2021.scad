// Drehzahlmesser-Gehäuse V2 2021-06-04
// jetzt für Reflexionslichtschranke mit Treibergedöns

// Angaben sind in mm

// gedruckt mit 0.2 und 60%

$fn = $preview ? 20 : 100;

// Breite der Halterung, Höhe der Wände
breite = 40.1;
hoehe = 12;

// Boden und Wand links/rechts
bodendicke = 8;
wandstaerke = 5;

// Seitenwände links und rechts (grün)
Seitenwandstaerke = 2;
Seitenwandueberstand = 5;

// Breite der Bucht und Rundungsradius
abstand = 11;
rundung = 7;

// Tiefe der Minihaltegnubbel (Rot)
Gnubtiefe = 0.3;
Gnubabstand = 2.2+1.9;
Gnubhoehe = 1.9;
Gnubdurchmesser = 4.4;

// ==================================================
// Aufbau der Objekte
boden=[2*wandstaerke+abstand,breite,bodendicke];
// Wand steht links/rechts bündig zum Boden
wand=[wandstaerke,breite,hoehe];

// Lichtschrankengehäuse
lsmargin = 0.1;
lsbreite = 5.8+lsmargin;
lsfront = 2.5+lsmargin;
lshoehe = 10.3+lsmargin;
lstiefe = 20.0; // egal.

// zwei verschiedene TCRT5000-Lichtschrankenmodule
// 0: 3-Pin-Connector mit auf PCB aufliegendem TCRT5000-Modul
// 3: 4-Pin-Connector mit auf PCB stehendem TCRT5000-Modul
lsofs = 3;

// Spiegelfläche
// Haushaltsalufolie einkleben
spbreite = 15.0;

//**************************************************************
// Zusammenbau der Teile
/**/
difference () {
    union() {
        gehaeuse();
        
        // Rand um Lichtschrankenloch
        translate([25-2+lsofs,breite/2.0,hoehe+1.2])
        rotate([-90,0,90])
        scale([1.4,1.3,0.3])
        lichtschranke();
    }

    // bodenplatte wg. durchstossenden Rundungen
    translate([-50,-50,-10])
    cube([100,100,10]);

    // Lichtschrankenloch
    translate([29,breite/2.0,hoehe+1.2])
    rotate([-90,0,90])
    lichtschranke();
    
    // Spiegelfläche
    translate([wandstaerke-1,(breite-spbreite)/2.0,bodendicke])
    cube([1,spbreite,20]);
}    
/**/

//**************************************************************
// linke und rechte Wand anfügen
module gehaeuse() {
    union() {
        // Basisplatte
        cube(boden);

        translate([0,0,boden[2]]) 
        rrect(wand,rundung);
        translate([boden[0]-wand[0],0,boden[2]]) 
        rrect(wand,rundung);
        
        // Seitenwände
        color("green")
        translate([0,-Seitenwandstaerke,0])
        cube([2*wandstaerke+abstand,Seitenwandstaerke,bodendicke+Seitenwandueberstand]);
        
        color("green")
        translate([0,breite,0])
        cube([2*wandstaerke+abstand,Seitenwandstaerke,bodendicke+Seitenwandueberstand]);
        
        // 4 Haltegnubbel für die Lüfterlöcher        
        color("red")
        translate([wandstaerke,Gnubabstand,bodendicke+Gnubdurchmesser/2+Gnubhoehe])
        rotate ([0,90,0])
        cylinder(h=Gnubtiefe,d=Gnubdurchmesser);
        
        color("red")
        translate([wandstaerke,breite-Gnubabstand,bodendicke+Gnubdurchmesser/2+Gnubhoehe])
        rotate ([0,90,0])
        cylinder(h=Gnubtiefe,d=Gnubdurchmesser);
        
        color("red")
        translate([wandstaerke+abstand-Gnubtiefe,Gnubabstand,bodendicke+Gnubdurchmesser/2+Gnubhoehe])
        rotate ([0,90,0])
        cylinder(h=Gnubtiefe,d=Gnubdurchmesser);
        
        color("red")
        translate([wandstaerke+abstand-Gnubtiefe,breite-Gnubabstand,bodendicke+Gnubdurchmesser/2+Gnubhoehe])
        rotate ([0,90,0])
        cylinder(h=Gnubtiefe,d=Gnubdurchmesser);
    };
}

//**************************************************************
module lichtschranke() {
    translate([-lsbreite/2.0,-lshoehe/2.0,0])
    difference() {    
        cube([lsbreite,lshoehe,lstiefe]);
        
        // furchtbares Ausprobieren.... gewinnt gar keine Preise....
        color("red")
        rotate([0,0,45])
        translate([lshoehe-0.0,1.9,0])
        cube([1.4,2.5,lstiefe]);
        
        color("blue")
        rotate([0,0,45])
        translate([lshoehe-4.1,5.9+0.4,0])
        cube([2.3,1.4,lstiefe]);
    }    
}

//=================================================================
module rrect(size, radius)
{
    union() {
        cube([size[0],size[1],size[2]-radius]);
        
        translate([0,radius,size[2]-radius]) 
        cube([size[0],size[1]-2*radius,radius]);
        
        translate([0,radius,size[2]-radius]) 
        rotate ([0,90,0]) 
        cylinder(h=size[0],r=radius );
        
        translate([0,size[1]-radius,size[2]-radius]) 
        rotate ([0,90,0]) 
        cylinder(h=size[0],r=radius);
   }
}
