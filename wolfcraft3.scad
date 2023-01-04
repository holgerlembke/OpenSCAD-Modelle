/*
    Wolfcraft - Winkelbacken
    
    ein weiterer Versuch, eigene Backen für die Wolfkraft-Zwingen
    zu modellieren
    
    + Wolfcraft FZH 40 Ergo-Federzwinge 3626000

    Gedruckt mit 60% Füllung.
    
    nicht probiert:
      Wolfcraft FZ 40 Federzwinge 3630000
      Wolfcraft FZR30 Ratschenzwinge 3016000 
*/

$fn = $preview ? 20 : 100;


pindm = 3.9 + 0.2;      // Durchmesser des Pinlochs
pinbreite = 12.0;         // Breite des Pinzylinders
pinwandst = 2.0;         // Wandstärke des Pinlochs

backenbreite = 20.0;
backenlaenge = 30.0;
backendicke = 5.0;
backenoffset = 10.0;

// die beiden Stege
stegachse = true;          // ohne diesen macht es keinen Sinn!
stegquer = true;
mittelfase = true;          // die "Zentrierfase" in der Mitte, 45° ohne Stützstruktur

winkelaussen();

translate([10,0,0])
winkelinnen();

//==================================================================
module winkelinnen() {
    steg = [ 
        [0,-pindm/2.0-pinwandst],
        [0,+pindm/2.0+pinwandst],
        [backenoffset-3,backenbreite/2.0],
        [backenoffset-3,-backenbreite/2.0]
        ];
    stegpkt = [[0,1,2,3]];

    steif = [ 
        [pindm/2.0+pinwandst,-pinbreite/2.0],
        [pindm/2.0+pinwandst,+pinbreite/2.0],
        [backenoffset-backendicke/2.0+1,8],
        [backenoffset-backendicke/2.0+1,-8]
        ];
    steifpkt = [[0,1,2,3]];

    pofs = 0;
    pgrid = 0.5;
    p45 = [[0,0],[-pgrid,0],[pgrid,-pgrid]];
    pp45 = [[0,1,2]];

    // die Mittelfase
    nutgrid = 1.5;
    nut45 = [[-nutgrid,0],[0,nutgrid],[0,-nutgrid]];
    nnut45 = [[0,1,2]];

    difference() {
        union() {
            color("red")
            rotate([0,45,0])
            translate([backenoffset,0,-3])
            cube([backendicke,backenbreite,backenlaenge], center=true);
            
            color("red")
            rotate([0,-45,0])
            translate([backenoffset,0,3])
            cube([backendicke,backenbreite,backenlaenge], center=true);

            rotate([0,180,0]) 
            translate([-18,0,0])
            {
                cylinder(h=pinbreite,d=pindm+2*pinwandst, center=true);
                
                // der Steg in Achsenausrichtung
                if (stegachse) {
                    color("blue")
                    linear_extrude(height=pinbreite, center = true, 
                                           convexity = 10, twist = 0)
                    polygon(steg,stegpkt);
                }
                
                // der Steg in Querrichtung
                if (stegquer) {
                color("green")
                    rotate([90,0,0])
                    linear_extrude(height=pindm+2.0*pinwandst, center = true, 
                                           convexity = 10, twist = 0)
                    polygon(steif,steifpkt);
                }
            }
        }
        
        union() {
            rotate([0,180,0]) 
            translate([-18,0,0])
            cylinder(h=pinbreite,d=pindm, center=true);

            rotate([90,0,0])
            translate([9,0,0])
            cylinder(h=backenbreite,r=2,center=true);
        }
    }
}

//==================================================================
module winkelaussen() {
    steg = [ 
        [0,-pindm/2.0-pinwandst],
        [0,+pindm/2.0+pinwandst],
        [backenoffset+1,backenbreite/2.0],
        [backenoffset+1,-backenbreite/2.0]
        ];
    stegpkt = [[0,1,2,3]];

    steif = [ 
        [pindm/2.0+pinwandst,-pinbreite/2.0],
        [pindm/2.0+pinwandst,+pinbreite/2.0],
        [backenoffset-backendicke/2.0,10],
        [backenoffset-backendicke/2.0,-10]
        ];
    steifpkt = [[0,1,2,3]];

    pofs = 0;
    pgrid = 0.5;
    p45 = [[0,0],[-pgrid,0],[pgrid,-pgrid]];
    pp45 = [[0,1,2]];

    // die Mittelfase
    nutgrid = 1.5;
    nut45 = [[-nutgrid,0],[0,nutgrid],[0,-nutgrid]];
    nnut45 = [[0,1,2]];


    difference() {
        union() {
            cylinder(h=pinbreite,d=pindm+2*pinwandst, center=true);
            
            color("red")
            rotate([0,45,0])
            translate([backenoffset,0,-3])
            cube([backendicke,backenbreite,backenlaenge], center=true);
            
            color("red")
            rotate([0,-45,0])
            translate([backenoffset,0,3])
            cube([backendicke,backenbreite,backenlaenge], center=true);

            // der Steg in Achsenausrichtung
            if (stegachse) {
                color("blue")
                linear_extrude(height=pinbreite, center = true, 
                                       convexity = 10, twist = 0)
                polygon(steg,stegpkt);
            }
            
            // der Steg in Querrichtung
            if (stegquer) {
            color("green")
                rotate([90,0,0])
                linear_extrude(height=pindm+2.0*pinwandst, center = true, 
                                       convexity = 10, twist = 0)
                polygon(steif,steifpkt);
            }
        }
        
        union() {
            cylinder(h=pinbreite,d=pindm, center=true);
            
            kopfdm = 6.0;
            translate([0,0,17])
            cylinder(h=pinbreite+10,d=kopfdm, center=true);
            translate([0,0,-17])
            cylinder(h=pinbreite+10,d=kopfdm, center=true);

            // Platz für Klemmgelenk
            nutbreite = 4.0;
            translate([3,0,pinbreite/2.0+nutbreite/2.0])
            cube([4.0,pinbreite,nutbreite],center=true);
            translate([3,0,-pinbreite/2.0-nutbreite/2.0])
            cube([4.0,pinbreite,nutbreite],center=true);
        }
    }
}

