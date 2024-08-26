/*
    
    Hubhalter für SSD/HDD-Case
    
    Anreihung: M3-Schraubniete + M3 Schraube x 25
    
*/

$fn = $preview ? 20 : 300;


// Settings
// Die vorbereitete Bohrung zum Anschrauben des USB-Hub-Halters
hubloch = 1; // 0: kein Hubloch, 1: Hubloch

// Nubsis zum Anreihen, falls die Module geklebt werden sollen
anreihnubs = 1; // 0: keine, 1: Nubsi zum exakten anreihen

// Schraubenlöcher zum Anreihen
// 0: keine
// 1: Standard, 4 Stück für lange Schrauben, universalm, Blindniete mit M3 Gewinde
schrloch = 1;

// Auswahl, ob hdd oder ssd
// ssd: 0 
// hdd: 1
dia = 35.0;
hoehe = 60.0;
abstand = 70.0;

steghoehe = 13.0;

breite = dia+4.0;

//M3-Blindniete
ndia = 4.9; // Aussendurchmesser
ndias = 8.5; // Aussendurchmesser der Kante
ntiefeg = 9.2;
ntiefes = 1.0;

gdia = 2.6; // Innendurchmesser Gewindeloch 2,459
sdia = 3.2; // Innendurchmesser des Anschnitt-Lochs
kdia = 7.0; // Kopfdurchmesser
khoehe = 28.0; // Kopfhöhe
ktiefe = 18.0; // Zusatztiefe für schrloch-typ 2+3
kanschnitt = 6.0; // Tiefe des Anschnitts für schrloch-typ 2+3
lochtiefe = 60.0;

// USB-Hub-Verbindung
usbhoehe = 5.0; // Tiefe des Anschnitt-Lochs
usbtiefe = 15.0; // Tiefe des USB-Hub-Gewindes

// Anreihnupsi
arndia = 5.0;

//color("black") translate([-6.8/2,0,0]) cube([6.8,70.0,100.0]);

// Schnittbild
/** /
intersection() {
    schenkel();
    translate([0,-50,0]) cube([200,200,200]);
}
/** /
intersection() {
    schenkel();
    translate([-50,-50,0]) cube([200,200,7]);
}
/**/
schenkel();
/**/

//********************************************************
module schenkel() {
    difference() {
        union() {
            hb = 30.0;
            hx = 5.0;
            hd = 25.0;
            ht = 23.0;   // hub tiefe
            
            translate([-breite/2,(abstand-hb)/2.0,steghoehe]) cube([hx,hb,hd]);
            translate([-breite/2+ht+hx,(abstand-hb)/2.0,steghoehe]) cube([hx,hb,hd]);
        
            // Verbindungssteg
            translate([-breite/2,0,0]) cube([breite,abstand,steghoehe]);
            translate([-dia/2,0,0]) cube([dia,abstand,steghoehe]);
            
            if (anreihnubs==1) {
                translate([-breite/2+arndia/2-1,25,5]) sphere(d=arndia);
                translate([-breite/2+arndia/2-1,abstand-25,5]) sphere(d=arndia);
            }
        }
        union() {
            // Schrauben zum Anreihen
            if (schrloch>0) {
                delta1=8;
                delta2=16;
                // Standard
                translate([-breite/2,delta1,steghoehe/2]) schraube(breite,khoehe);
                translate([-breite/2,abstand-delta1,steghoehe/2]) schraube(breite,khoehe);
                translate([-breite/2,delta2,steghoehe/2]) schraube(breite,khoehe);
                translate([-breite/2,abstand-delta2,steghoehe/2]) schraube(breite,khoehe);
            }

            if (anreihnubs==1) {
                translate([+breite/2+arndia/2-1,25,5]) sphere(d=arndia+0.1);
                translate([+breite/2+arndia/2-1,abstand-25,5]) sphere(d=arndia+0.1);
            }
        }
    }
}

//********************************************************
module schraube(laenge,kopfhoehe) {
    anscht = 4.0;
    rotate([0,90,0]) {
        cylinder(d=kdia,h=kopfhoehe);
        translate([0,0,kopfhoehe]) cylinder(d=sdia,h=laenge);
    }
}

//********************************************************
module schraubenloch(laenge,anschnitt) {
    rotate([0,90,0]) {
        cylinder(d=sdia,h=anschnitt);
        translate([0,0,anschnitt]) cylinder(d=gdia,h=laenge);
    }
}

