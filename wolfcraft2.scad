/*
    Wolfcraft - Backen
    
    ein weiterer Versuch, eigene Backen für die Wolfkraft-Zwingen
    zu modellieren
    
    + Wolfcraft FZH 40 Ergo-Federzwinge 3626000

    
    nicht probiert:
      Wolfcraft FZ 40 Federzwinge 3630000
      Wolfcraft FZR30 Ratschenzwinge 3016000 
*/

$fn = $preview ? 20 : 100;


pindm = 3.9 + 0.2;      // Durchmesser des Pinlochs
pinbreite = 12.0;         // Brette des Pinzylinders
pinwandst = 2.0;         // Wandstärke des Pinlochs

backenbreite = 20.0;
backenlaenge = 40.0;
backendicke = 5.0;
backenoffset = 10.0;

// die beiden Stege
stegachse = true;          // ohne diesen macht es keinen Sinn!
stegquer = true;

steg=[ 
    [0,-pindm/2.0-pinwandst],
    [0,+pindm/2.0+pinwandst],
    [backenoffset-backendicke/2.0,backenbreite/2.0],
    [backenoffset-backendicke/2.0,-backenbreite/2.0]
    ];
stegpkt=[[0,1,2,3]];

steif=[ 
    [pindm/2.0+pinwandst,-pinbreite/2.0],
    [pindm/2.0+pinwandst,+pinbreite/2.0],
    [backenoffset-backendicke/2.0,backenlaenge/2.0],
    [backenoffset-backendicke/2.0,-backenlaenge/2.0]
    ];
steifpkt=[[0,1,2,3]];


difference() {
    union() {
        cylinder(h=pinbreite,d=pindm+2*pinwandst, center=true);
        
        translate([backenoffset,0,0])
        cube([backendicke,backenbreite,backenlaenge], center=true);
        
        // der Steg in Achsenausrichtung
        if (stegachse) {
            linear_extrude(height=pinbreite, center = true, 
                                   convexity = 10, twist = 0)
            polygon(steg,stegpkt);
        }
        
        // der Steg in Querrichtung
        if (stegquer) {
            rotate([90,0,0])
            linear_extrude(height=pindm+2.0*pinwandst, center = true, 
                                   convexity = 10, twist = 0)
            polygon(steif,steifpkt);
        }
    }
    
    union() {
        cylinder(h=pinbreite,d=pindm, center=true);
    }
}


