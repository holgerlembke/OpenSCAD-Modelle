/*

  M3-Schraubenklebehilfe
  
  Kopfüber drucken!

*/


$fn = $preview ? 10 : 50;   // hier ändern für schnelleres Rendern

/*
Schlitzschraube
    din 84 / m3
    kopfhöhe 2.5
    kopfdurchmesser 5.5

*/

hoehe = 10.0;
durchmesserunten = 14.0;
durchmesseroben = 6.0;

schraubendurchmesser = 2.4;
schraubenkopfhoehe = 3.1;
schraubenkopfdurchmesser = 5.7;



difference() {
    union() {
        cylinder(h=hoehe, r1=durchmesserunten/2.0, r2=durchmesseroben/2.0);
    }
    
    union() {
        translate([0,0,-1])
        cylinder(h=hoehe+2.0, d=schraubendurchmesser);

        translate([0,0,-1])
        cylinder(h=schraubenkopfhoehe+1, d=schraubenkopfdurchmesser);
    }
}





