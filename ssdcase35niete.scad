/*
    
    anreihbarer Halter für 3.5" HDD
    
    Anreihung: M3-Schraubniete + M3 Schraube x 30
    HDD: Schraube #6-32unc 3/4" lang
    
*/

$fn = $preview ? 20 : 300;


// Settings
// Die vorbereitete Bohrung zum Anschrauben des USB-Hub-Halters
hubloch = 1; // 0: kein Hubloch, 1: Hubloch

// Nubsis zum Anreihen, falls die Module geklebt werden sollen
anreihnubs = 1; // 0: keine, 1: Nubsi zum exakten anreihen

// Schraubenlöcher zum Anreihen
// 0: keine
// 1: Standard, 4 Stück für lange Schrauben, universal
schrloch = 1;

dia = 24.0;
slot = 40;
hoehe = 103.0;
abstand = 102.0;

abstands = 70.0; // für die Löcher/Zentrierer

steghoehe = 13.0;

breite = dia+6.0;

//M3-Schraube
gdia = 2.6; // Innendurchmesser Gewindeloch 2,459
sdia = 3.2; // Innendurchmesser des Anschnitt-Lochs
kdia = 7.0; // Kopfdurchmesser
khoehe = 10.0; // Kopfhöhe
ktiefe = 18.0; // Zusatztiefe für schrloch-typ 2+3
kanschnitt = 6.0; // Tiefe des Anschnitts für schrloch-typ 2+3
lochtiefe = 60.0;

// USB-Hub-Verbindung
usbhoehe = 5.0; // Tiefe des Anschnitt-Lochs
usbtiefe = 15.0; // Tiefe des USB-Hub-Gewindes

// Anreihnupsi
arndia = 5.0;

//M3-Blindniete
ndia = 4.9; // Aussendurchmesser
ndias = 8.5; // Aussendurchmesser der Kante
ntiefeg = 9.2;
ntiefes = 1.0;

// HDD-Rahmen
// für Schraube #6-32unc 3/4" lang
hddldm = 3.6;
hddrdm = 8.1;
hhdldistz = (62.7+57.1)/2.0;
hhdstegh = steghoehe+19.0;
hddstegofs = 6.0;

//color("black") translate([-6.8/2,0,0]) cube([6.8,70.0,100.0]);

// Schnittbild
/** /
intersection() {
    schenkel();
    translate([0,-50,0]) cube([200,200,200]);
}
/**/
schenkel();
/**/

//********************************************************
module schenkel() {
    difference() {
        union() {
            /**/
            difference() {
                union() {
                    cylinder(d=dia,h=hoehe-dia/2);
                    translate([0,0,hoehe-dia/2]) sphere(d=dia);
                }
                translate([-slot/2,0,0]) cube([slot,dia,hoehe]);
            }

            translate([0,abstand,0])
            difference() {
                union() {
                    cylinder(d=dia,h=hoehe-dia/2);
                    translate([0,0,hoehe-dia/2]) sphere(d=dia);
                }
                translate([-slot/2,-dia,0]) cube([slot,dia,hoehe]);
            }
            /**/
            dd = 3.1;
            
            // Verbindungssteg
            translate([-breite/2,dd/2.0,0]) cube([breite,abstand-dd,steghoehe]);
            translate([-dia/2,0,0]) cube([dia,abstand,steghoehe]);
            
            // Rundungsgedöns
            for (j=[0:1]) {
                for (i=[-1:2:1]) {
                    translate([i*(breite-dd)/2.0,j*(abstands-dd)+dd/2.0,0]) cylinder(d=dd,h=steghoehe);
                    translate([i*(breite-dd)/2.0-(i+1)*dd/2,j*(abstands)-dd/2.0,0]) 
                    difference() {
                        cube([dd,dd,steghoehe]);
                        translate([(i+1)*dd/2,j*dd,0]) cylinder(d=dd,h=steghoehe);
                    }
                }
            }
            
            
            if (anreihnubs==1) {
                translate([-breite/2+arndia/2-1,25,5]) sphere(d=arndia);
                translate([-breite/2+arndia/2-1,abstands-25,5]) sphere(d=arndia);
            }

            // Löcher zum Anschrauben der HDD
            seitenloecher(hddrdm,12);
        }
        union() {
            // Befestigungsschraube für usb-Hub
            if (hubloch==1) {
                rotate([0,0,90]) translate([-dia/2,0,dia-3]) schraubenloch(usbtiefe,usbhoehe);
            }

            // Löcher zum Anschrauben der HDD
            seitenloecher(hddldm,20);

            // Schrauben zum Anreihen
            if (schrloch>0) {
                delta1=8;
                delta2=16;
                // Standard
                translate([-breite/2,delta1,steghoehe/2]) schraube(breite,khoehe);
                translate([-breite/2,abstands-delta1,steghoehe/2]) schraube(breite,khoehe);
                translate([-breite/2,delta2,steghoehe/2]) schraube(breite,khoehe);
                translate([-breite/2,abstands-delta2,steghoehe/2]) schraube(breite,khoehe);
            }
            
            if (anreihnubs==1) {
                translate([+breite/2+arndia/2-1,25,5]) sphere(d=arndia+0.1);
                translate([+breite/2+arndia/2-1,abstands-25,5]) sphere(d=arndia+0.1);
            }
        }
    }
}

//********************************************************
module seitenloecher(dd, hh) {
    translate([hddstegofs,0,hhdstegh]) {
        translate([0,0,0]) rotate([90,0,0]) cylinder(d=dd,h=hh);
        translate([0,0,hhdldistz]) rotate([90,0,0]) cylinder(d=dd,h=hh);
        translate([0,abstand+hh,0]) rotate([90,0,0]) cylinder(d=dd,h=hh);
        translate([0,abstand+hh,hhdldistz]) rotate([90,0,0]) cylinder(d=dd,h=hh);
    }
}

//********************************************************
module schraube(laenge,kopfhoehe) {
    anscht = 4.0;
    rotate([0,90,0]) {
        cylinder(d=kdia,h=kopfhoehe);
        translate([0,0,khoehe]) cylinder(d=sdia,h=laenge);
        
        translate([0,0,laenge-ntiefeg]) cylinder(d=ndia,h=ntiefeg);
        translate([0,0,laenge-ntiefes]) cylinder(d=ndias,h=ntiefes);
    }
}

//********************************************************
module schraubenloch(laenge,anschnitt) {
    rotate([0,90,0]) {
        cylinder(d=sdia,h=anschnitt);
        translate([0,0,anschnitt]) cylinder(d=gdia,h=laenge);
    }
}

