/*
     Halterung für Pumpe
     
*/

$fn = $preview ? 20 : 100;


laenge = 20.0;  // Slot-Breite
breite = 20.0;
dicke = 7.0;
stegbreite = 6.2;
steghoehe = 2.0;
stegluecke = 16.0;

seitenwandhoehe = 10.0;
seitendicke = 4.0;

// Steg
lochdurchmesser = 4.5;

// Schraube
schraubenkopfdurchmesser = 10.0;
schraubenkopfhoehe = 3.0;

// Straps
strapsdurchmesser = 3.0;

halterhoehe = 20.0;
halterinnendm = 33.0;
halteraussendm = halterinnendm+dicke;

difference() {
    union() {
        // Basisplatte
        cube([laenge,breite,dicke]);

        // der Steg fürs Aluprofil
        translate([10.0-stegbreite/2,0,-steghoehe]) 
        cube([stegbreite,breite,steghoehe+1.0]);
        
        translate([10,0,halterinnendm/2.0+dicke])
        rotate([90,0,0])
        cylinder(h=halterhoehe,d=halteraussendm);

    }
    
    union() {
        // die Schraubenlöcher+Schraubenkopf
        translate([10.0,breite/2.0,-10.0]) 
        cylinder(h=20.0, d=lochdurchmesser);

        translate([10.0,breite/2.0,dicke-schraubenkopfhoehe]) 
        cylinder(h=schraubenkopfhoehe+1.0, d=schraubenkopfdurchmesser);

        // Lücke im Steg
        translate([0,(breite-stegluecke)/2.0,-steghoehe]) 
        cube([laenge,stegluecke,steghoehe]);

        translate([10,1,halterinnendm/2.0+dicke])
        rotate([90,0,0])
        cylinder(h=halterhoehe+2,d=halterinnendm);
        
        translate([ -halterinnendm/2.0+dicke-1,
                        -halterhoehe-1,
                        halterinnendm/2+dicke+1])
        cube([halteraussendm+2,halterhoehe+2,40]);
    }    
}



