/*
    Wolfcraft - Backen
    
    ein weiterer Versuch, eigene Backen für die Wolfkraft-Zwingen
    zu modellieren
    
    + Wolfcraft FZH 40 Ergo-Federzwinge 3626000
    + Wolfcraft FZ 40 Federzwinge 3630000

    Gedruckt mit 60% Füllung.
*/

$fn = $preview ? 20 : 100;


pindm = 3.9 + 0.2;      // Durchmesser des Pinlochs
pinbreite = 12.0;         // Breite des Pinzylinders
pinwandst = 2.0;         // Wandstärke des Pinlochs

backenbreite = 150.0;
backenlaenge = 12.0;
backendicke = 5.0;
backenoffset = 10.0;
backendelta = 20.0;

// die beiden Stege
stegachse = true;          // ohne diesen macht es keinen Sinn!
stegquer = true;
mittelfase = true;          // die "Zentrierfase" in der Mitte, 45° ohne Stützstruktur

steg = [ 
    [0,-pindm/2.0-pinwandst+5],
    [0,+pindm/2.0+pinwandst-5],
    [backenoffset-backendicke/2.0,-backenbreite+backendelta],
    [backenoffset-backendicke/2.0,backendelta]
    ];
stegpkt = [[0,1,2,3]];

steif = [ 
    [pindm/2.0+pinwandst,-pinbreite/2.0],
    [pindm/2.0+pinwandst,+pinbreite/2.0],
    [backenoffset-backendicke/2.0,backenlaenge/2.0],
    [backenoffset-backendicke/2.0,-backenlaenge/2.0]
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
        translate([backenoffset,-backenbreite/2.0+backendelta,0])
        cube([backendicke,backenbreite,backenlaenge], center=true);
        
        // der Steg in Achsenausrichtung
        if (stegachse) {
            color("blue")
            linear_extrude(height = pinbreite, center = true, 
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
        
        // Der Spreizer
        translate([15,backendelta-5,0])
        cube([10,10,backenlaenge],center=true);
        
    }
    
    union() {
        cylinder(h=pinbreite,d=pindm, center=true);

        translate([19,-70,0])
        rotate([0,0,-2])
        cube([10,200,40],center=true);
    }
}


