/*
    
    anreihbarer Halter für 2.5" SSD + HDD

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
hdd=0;

dia = (hdd==1) ? 22.0 : 13.0;
slot = (hdd==1) ? 25.4/2.0 : 8.0; 
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
khoehe = (hdd==1) ? 10.0 : 3.0; // Kopfhöhe
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
            dd = 2.082;
            
            // Verbindungssteg
            translate([-breite/2,dd/2.0,0]) cube([breite,abstand-dd,steghoehe]);
            translate([-dia/2,0,0]) cube([dia,abstand,steghoehe]);
            
            // Rundungsgedöns
            for (j=[0:1]) {
                for (i=[-1:2:1]) {
                    translate([i*(breite-dd)/2.0,j*(abstand-dd)+dd/2.0,0]) cylinder(d=dd,h=steghoehe);
                    translate([i*(breite-dd)/2.0-(i+1)*dd/2,j*(abstand)-dd/2.0,0]) 
                    difference() {
                        cube([dd,dd,steghoehe]);
                        translate([(i+1)*dd/2,j*dd,0]) cylinder(d=dd,h=steghoehe);
                    }
                }
            }
            
            rotate([0,90,0]) translate([-steghoehe,steghoehe,-breite/2]) cylinder(d=3,h=breite);
            rotate([0,90,0]) translate([-steghoehe,abstand-steghoehe,-breite/2]) cylinder(d=3,h=breite);
            
            if (anreihnubs==1) {
                translate([-breite/2+arndia/2-1,25,5]) sphere(d=arndia);
                translate([-breite/2+arndia/2-1,abstand-25,5]) sphere(d=arndia);
            }
        }
        union() {
            // Befestigungsschraube für usb-Hub
            if (hubloch==1) {
                rotate([0,0,90]) translate([-dia/2,0,dia-3]) schraubenloch(usbtiefe,usbhoehe);
            }

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

            // die Designecke
            rotate([0,90,0]) translate([-38.9,abstand/2.0,-breite/2]) 
            cylinder(d=abstand-5,h=breite);

            if (anreihnubs==1) {
                translate([+breite/2+arndia/2-1,25,5]) sphere(d=arndia+0.1);
                translate([+breite/2+arndia/2-1,abstand-25,5]) sphere(d=arndia+0.1);
            }
        }
    }
}

/*
ndia = 3.7; // Aussendurchmesser
ndias = 8.5; // Aussendurchmesser der Kante
ntiefeg = 9.2;
ntiefes = 1.0;
*/

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

