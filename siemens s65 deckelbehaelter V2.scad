/* Deckelbehälter für die Siemens S65 Kaffeemaschine
    auf das Unterteil wird eine Plastikdose gesetzt und mit
    den beiden Schienen fixiert.
*/    

// Deckel liegt im Hochformat mit langer Seite rechts vor mir.

$fn = $preview ? 80 : 200;

// Dimensionen 
wandstaerke = 4;
tiefe = 5;

// Länge (Aussennmasse)
lt = 158; // war 159
// Breite
lb = 48;

// Innenradien, gezählt im Uhrzeigersinn, Beginn ist unten rechts
// unten rechts
ri1 = 2;
// unteren linken 
ri2 = 10;
// oben links 
ri3 = 7;
// oben mitte unten
ri4=15;
// oben mitte oben
ri5=7;
// oben rechts
ri6 = ri1;

// Abstände zwischen den Rundungen
l45 = 0.1;  // bezieht sich auf lt
l56 = 0;  // bezieht sich auf lb

// Restlichen Längen ergeben sich über Gesamtlänge/-breite:
l23 = lt-ri2-wandstaerke-ri5-wandstaerke-l45-ri4-wandstaerke-ri3;
l34 = lb-l56-ri3-ri4-ri5-ri6-3*wandstaerke;

steglaenge = 8;

rotate([180,0,0]) { // dann ist es im Slicer automatisch richtig rum
    // Basis
    hb=5.0;
    basis(true,false,false, false,hb);

    // Stufe 1
    h1=5.0;
    color("green")
    translate([0,0,-h1])
    basis(false,false,false,true,h1);

    // Stufe 2
    h2=4.0;
    color("blue")
    translate([0,0,-h1-h2])
    basis(false,false,true,false,h2);
    
    // Hals
    ha=1.0;
    translate([0,0,-h1-h2-ha])
    color("red")
    basis(false,false,false,false,ha);

    // Schraubdeckel
    hs=5.0;
    translate([0,0,-h1-h2-ha-hs])
    basis(false,true,false,false,hs);
}

translate([-25,0,0])
steg();
translate([50,0,0])
steg();


module steg() {
    rotate([180,0,0]) { // dann ist es im Slicer automatisch richtig rum
        hd=5.0;

        difference() { 
            // Einzelner Schraubdeckel
            translate([-10,-60,0])
            basis(false,true,false,false,hd);
            
            union() {
                translate([12-30,-65,-1])
                cube([40,60,hd+2.0]);
              
                translate([90,-65,-1])
                cube([70,60,hd+2.0]);

                translate([21,-75,-1])
                cube([70,30,hd+2.0]);
            }
        }
    }
}


//********************************************************************
module basis(
bodensteg, schraubenpunkte, 
stegrechts, steglinks,
atiefe) {
            
    union () {
        // Wand rechts
        translate([ri1+wandstaerke,0,0])
        cube ([lt-2*(wandstaerke+ri1),wandstaerke,atiefe]);

        // Wand unten
        translate([0,ri1+wandstaerke,0])
        cube ([wandstaerke,lb-ri2-ri1-2*wandstaerke,atiefe]);
        
        // Wand links
        translate([ri2+wandstaerke,lb-wandstaerke,0])
        cube ([l23,wandstaerke,atiefe]);
        
        // Wand zwischen R3+R4
        translate([ri2+l23+ri3+wandstaerke,lb-ri3-l34-wandstaerke,0])
        cube ([wandstaerke,l34,atiefe]);
        
        // Wand zwischen R5+R6
        translate([lt-wandstaerke,ri6+wandstaerke,0])
        cube ([wandstaerke,l56,atiefe]);
        
        // Wand zwischen R4+R5
        translate([lt-wandstaerke-ri5-l45,ri6+l56+ri5+wandstaerke,0])
        cube ([l45,wandstaerke,atiefe]);
        
        // Bodensteg
        if (bodensteg) {
          translate([lt/3-ri4/3,0,0])
          cube ([wandstaerke,lb,atiefe]);

          translate([2*lt/3-2*ri4/3,0,0])
          cube ([wandstaerke,lb,atiefe]);
        }
        
        // Schraubenansätze
        if (schraubenpunkte) {
            translate([lt/3-ri4/3-5,-2,0])
            difference() {
                cylinder(d=10,h=tiefe);
                translate([0,0,-0.1])
                cylinder(d=3,h=tiefe+0.2);
            }

            translate([lt/3-ri4/3-5,lb+2,0])
            difference() {
                cylinder(d=10,h=tiefe+0.1);
                translate([0,0,-0.1])
                cylinder(d=3,h=tiefe+0.1+0.2);
            }

            translate([2*lt/3-ri4/3-10,-2,0])
            difference() {
                cylinder(d=10,h=tiefe);
                translate([0,0,-0.1])
                cylinder(d=3,h=tiefe+0.2);
            }

            translate([2*lt/3-ri4/3-10,lb+2,0])
            difference() {
                cylinder(d=10,h=tiefe);
                translate([0,0,-0.1])
                cylinder(d=3,h=tiefe+0.2);
            }
        }
        
        // Steg rechts
        if (stegrechts) {
            translate([0.4*lt/3-ri4/3,-steglaenge+2,0])
            cube([10,steglaenge,tiefe]);

            translate([1.3*lt/3-ri4/3,-steglaenge+2,0])
            cube([10,steglaenge,tiefe]);

            translate([2.1*lt/3-ri4/3,-steglaenge+2,0])
            cube([10,steglaenge,tiefe]);
        }
                       
        // Steg links
        if (steglinks) {
            translate([0.4*lt/3-ri4/3,lb-2,0])
            cube([10,steglaenge,tiefe]);

            translate([1.3*lt/3-ri4/3,lb-2,0])
            cube([10,steglaenge,tiefe]);

            translate([2.1*lt/3-ri4/3,lb-2,0])
            cube([10,steglaenge,tiefe]);
        }

        // Rundung r1
        difference() {
            translate([ri1+wandstaerke,ri1+wandstaerke,0])
            cylinder(h=atiefe,r=ri1+wandstaerke);
            
            color("red")
            translate([ri1+wandstaerke,ri1+wandstaerke,-1])
            cylinder(h=atiefe+2,r=ri1);
            
            color("blue")
            translate([ri1+wandstaerke,0,-1])
            cube([(ri1+wandstaerke),2*(ri1+wandstaerke),atiefe+2]);
            
            color("green")
            translate([0,ri1+wandstaerke,-1])
            cube([2*(ri1+wandstaerke),(ri1+wandstaerke),atiefe+2]);
        }

        // Rundung r2
        difference() {
            translate([ri2+wandstaerke,lb-ri2-wandstaerke,0])
            cylinder(h=atiefe,r=ri2+wandstaerke);
            
            color("red")
            translate([ri2+wandstaerke,lb-ri2-wandstaerke,-1])
            cylinder(h=atiefe+2,r=ri2);
            
            color("blue")
            translate([ri2+wandstaerke,lb-2*(ri2+wandstaerke),-1])
            cube([(ri2+wandstaerke),2*(ri2+wandstaerke),atiefe+2]);
            
            color("green")
            translate([0,lb-2*(ri2+wandstaerke),-1])
            cube([2*(ri2+wandstaerke),(ri2+wandstaerke),atiefe+2]);
        }

        // Rundung r3
        difference() {
            translate([ri2+l23+wandstaerke,lb-ri3-wandstaerke,0])
            cylinder(h=atiefe,r=ri3+wandstaerke);
            
            color("red")
            translate([ri2+l23+wandstaerke,lb-ri3-wandstaerke,-1])
            cylinder(h=atiefe+2,r=ri3);
            
            color("blue")
            translate([ri2+l23-ri3,lb-2*(ri3+wandstaerke),-1])
            cube([(ri3+wandstaerke),2*(ri3+wandstaerke),atiefe+2]);
            
            color("green")
            translate([ri2+l23-ri3,lb-2*(ri3+wandstaerke),-1])
            cube([2*(ri3+wandstaerke),(ri3+wandstaerke),atiefe+2]);
        }

        // Rundung R4
        difference() {
            translate([ri2+l23+ri3+ri4+2*wandstaerke,lb-l34-ri3-wandstaerke,0])
            cylinder(h=atiefe,r=ri4+wandstaerke);
            
            color("red")
            translate([ri2+l23+ri3+ri4+2*wandstaerke,lb-l34-ri3-wandstaerke,-1])
            cylinder(h=atiefe+2,r=ri4);
            
            color("blue")
            translate([ri2+l23+ri3+ri4+2*wandstaerke,lb-l34-ri3-2*wandstaerke-ri4,-1])
            cube([(ri4+wandstaerke),2*(ri4+wandstaerke),atiefe+2]);
            
            color("green")
            translate([ri2+l23+ri3+wandstaerke,lb-l34-ri3-wandstaerke,-1])
            cube([2*(ri4+wandstaerke),(ri4+wandstaerke),atiefe+2]);
        }
        
        // Rundung r5
        difference() {
            translate([lt-ri5-wandstaerke,l56+ri6+wandstaerke,0])
            cylinder(h=atiefe,r=ri5+wandstaerke);
            
            color("red")
            translate([lt-ri5-wandstaerke,l56+ri6+wandstaerke,-1])
            cylinder(h=atiefe+2,r=ri5);
            
            color("blue")
            translate([lt-2*(ri5+wandstaerke),l56+ri6-ri5,-1])
            cube([(ri5+wandstaerke),2*(ri5+wandstaerke),atiefe+2]);
            
            color("green")
            translate([lt-2*(ri5+wandstaerke),l56+ri6-ri5,-1])
            cube([2*(ri5+wandstaerke),(ri5+wandstaerke),atiefe+2]);
        }
        
        // Rundung r6
        difference() {
            translate([lt-ri6-wandstaerke,ri6+wandstaerke,0])
            cylinder(h=atiefe,r=ri6+wandstaerke);
            
            color("red")
            translate([lt-ri6-wandstaerke,ri6+wandstaerke,-1])
            cylinder(h=atiefe+2,r=ri6);
            
            color("blue")
            translate([lt-2*(ri6+wandstaerke),0,-1])
            cube([(ri6+wandstaerke),2*(ri6+wandstaerke),atiefe+2]);
            
            color("green")
            translate([lt-2*(ri6+wandstaerke),ri6+wandstaerke,-1])
            cube([2*(ri6+wandstaerke),(ri6+wandstaerke),atiefe+2]);
        }
    }    
}




