/*

  Total simples, oben offenes Gehäuse
  Mit Löchern. Also aus Lochblech.
  
  Rendert unglaublich langsam, weil die vielen Löcher rund sind...
*/


$fn = $preview ? 20 : 100;   // hier ändern für schnelleres Rendern

wanddicke = 2.0;
innenlaenge = 18.0;
innenbreite = 56.0;
innenhoehe = 16.0;

// Lochung
lochdurchmesser = 3.0;

//
nutzelochung = true;

//Zusammenbau
difference() {
    gehaeuse();
    if (nutzelochung) {
        loecher();
    }
}

//==============================================================
module gehaeuse() {
    // Boden
    translate([0,0,-wanddicke])
    cube([innenlaenge,innenbreite,wanddicke]);

    // Wand vo+hi
    color("red") {
        translate([0,-wanddicke,-wanddicke])
        cube([innenlaenge,wanddicke,innenhoehe+wanddicke]);

        translate([0,innenbreite,-wanddicke])
        cube([innenlaenge,wanddicke,innenhoehe+wanddicke]);
    }

    // Wand li+re
    color("blue") {
        translate([-wanddicke,-wanddicke,-wanddicke])
        cube([wanddicke,innenbreite+2*wanddicke,innenhoehe+wanddicke]);
        
        translate([innenlaenge,-wanddicke,-wanddicke])
        cube([wanddicke,innenbreite+2*wanddicke,innenhoehe+wanddicke]);
    }
}

//==============================================================
module loecher() {
    // Boden
    translate([0,0,-wanddicke])
    gitterstaebe(innenlaenge,innenbreite);
    
    // Wand vo+hi
    rotate([90,0,0])
    translate([0,wanddicke/2.0,0])
    gitterstaebe(innenlaenge,innenhoehe-wanddicke);

    rotate([90,0,0])
    translate([0,wanddicke/2.0,-innenbreite-wanddicke])
    gitterstaebe(innenlaenge,innenhoehe-wanddicke);

    // Wand li+re
    rotate([0,-90,0])
    translate([0,wanddicke/2.0,0])
    gitterstaebe(innenhoehe-wanddicke/2,innenbreite-wanddicke);

    rotate([0,-90,0])
    translate([0,wanddicke/2.0,-innenlaenge-wanddicke])
    gitterstaebe(innenhoehe-wanddicke/2,innenbreite-wanddicke);
}

//==============================================================
module gitterstaebe(laenge, breite) {
    enge = 1.4;
    
    il = floor(laenge/(wanddicke+lochdurchmesser)*enge);
    ib = floor(breite/(wanddicke+lochdurchmesser)*enge);

    deltal = laenge/il;
    deltab = breite/ib;

    for (i=[1:il],j=[1:ib]) {
        ofs = (j % 2)*deltab/2.0;
        dx = (i-1)*deltal+ofs+deltal/2.0;
        dy = (j-1)*deltab+deltab/2.0;
        if ( (dx+lochdurchmesser/2.0<laenge) && 
             (dy+lochdurchmesser/2.0<breite) ) {
            translate([dx,dy,-0.5])
            cylinder(d=lochdurchmesser,h=wanddicke+1.0);
        }
    }  
}
