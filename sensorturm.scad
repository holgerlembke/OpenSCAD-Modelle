/*
        Sensorturm
        
        2024-11-05
*/

$fn = $preview ? 20 : 300;

// die Gitter-Rückseite
borderw = 2.0;
borderh = 7.0;

pcbx = 70.0 + 1.0;
pcby = 50.0 + 1.0;
pcbh = 1.0;
pcbdh = 10.0;

bohrdm = 3.5;
bohrx = 23 * (2.54);
bohry = 17 * (2.54);

standdm = 6.5;
standh = 19.0;

bpanellock = 4.0;    // die Kugel
bpanelofs = 10.0;   // Abstand zum Rand


// Der Standturm
turmda = 80.0;
turmdi = turmda-6.0;
turmhoofs = 30;
turmho = pcbx+2*borderw+pcbdh+turmhoofs;


// die Deckelplatte
deckelx = turmda+20;
deckely = turmda;
deckelh = 2;

deckeloleddm = 2.2;
deckelblx = 22.1; // 27.8-4.0;
deckelbly = 22.1;  // 27.3-4.0;
deckelsfx = 10.86+2;   // Sichtloch
deckelsfy = 21.74+2;   // Sichtloch
deckeldispofs = -5;             // Verschiebung des Displays
deckelswitchofs = -5;
deckeldisth = 1.5;

// Bodengesamthöhe
turmh = 20.0;

// Taster/Schalter
TSlochdm = 6.6;

TSpos1 = [28,turmda/2+5,0];
TSpos2 = [28,turmda/2-5,0];
TSpos3 = [16,turmda/2,0];

pcbshift = 5;
pcbtranslate = [29,-55.0/2,pcbshift];

deckelrotate = [0,-30,0];
deckeltranslate = [-turmda/2,-turmda/2,36+turmhoofs];

// Schraubverbinder Boden-Turm
bodenturmBlindndm = 4.95;              // dm der Blindniete-Innen
bodenturmth = 10;                           // Höhe im Turm 
bodenturmthdm = 9;                        // Rundungsdm aussen im Turm

bodenturmbodm = 5.8;                    // Schraubenkopfloch DM im Boden
bodenturmbodh = 3.0;                     // Schraubenkopfhöhe im Boden

bodenlochschdm = 8;                       // Aussen DM der Hülse
bodenlochschh = 20;                        // Höhe der Hülse
bodenlochschdmi = 3.6;                   // Innenlich DM für M3-Schraube

// Batteriehalter Verschieber und Dreher
batschieber = [-24,0,2];
batdreher = [0,0,0];  // 0,0,zz

// LGT8F328P-halter Verschieber und Dreher
lgtschieber = [-22.5,-25.8,2];
lgtdreher = [0,0,-25]; // 0,0,zz

// Ladepcbhalter Verschieber und Dreher
chrgschieber = [-0,8.4,2];
chrgdreher = [0,0,90]; // 0,0,zz

// Verschieben der Schraubeverbindung Boden + Turm
schraubenschieber1 = [-23.5,23.5,0];
schraubenschieber2 = [4.5,-32.5,0];


// ==========================================================================
// Druckteile im Zusammenbau (so hingeschoben, dass es gut aussieht)
translate([29.3,-27.5,5]) rotate([0,-90,0]) pcbbackpanel();
turm() ;
translate([0,0,-turmh]) boden();




//================================================================================
module boden() {
    // Boden 
    bodenh = 2.0;

    // Batterie
    batdm = 19.0;
    bath = 30.0;
    batw = 2;
    batsw = 10;
    
    // LGT8F328P-LQFP48
    lgtx = 18.7;
    lgtz = 44.2;
    lgtw = 2.0;
    lgtusbdm = 13.0;
    lgtwh = 6.0;
    
    // Ladeboard
    chrgx = 24.0;
    chrgz = 34.0;
    chrgw = 2.0;
    chrgwh = 6.0;
    chrgusbz = 10.0;
    chrgusbdm = 9.0;
    chrgusbschieber = [chrgx,chrgwh/2+0,13];

    intersection() {
        union() {
            difference() {
                union() {
                    difference() {
                        // äußerer Zylinder incl. Boden
                        color("lightgray") cylinder(d=turmda,h=turmh);
                        // äußerer Zylinder
                        translate([0,0,bodenh]) cylinder(d=turmdi,h=turmh);
                        // Boden
                        // color("lightgray") translate([-40,-40,0]) cube([80,80,bodenh]);
                    }

                    b = 50.0;
                    translate([26,-b/2.0,0]) cube([3,b,turmh]);
                    
                    // Akkuhalter
                    color("gray") translate(batschieber) rotate(batdreher) {
                        cylinder(d=batdm+2*batw,h=bath);
                        // Kabelstrapshalter
                        translate([batdm/2+batw,-batw/2,bath-2]) cube([1,2,2]);
                        translate([batdm/2+batw,-batw/2,bath-2-5-2]) cube([1,2,2]);
                    }
                    
                    // lgt8f board
                    color("lightgreen") translate(lgtschieber) rotate(lgtdreher) {
                        // Rückseite
                        cube([lgtx,lgtw,lgtz]);
                        // Wände
                        translate([-lgtw,0,0]) cube([lgtw,lgtwh,lgtz]);
                        translate([lgtx,0,0]) cube([lgtw,lgtwh,lgtz]);
                        translate([-lgtw,0,lgtz]) cube([lgtx+2*lgtw,lgtwh,lgtw]);
                        // Versteifung
                        translate([lgtx,-2,0]) cube([5,lgtwh+4,7]);
                        translate([-5,-2,0]) cube([5,lgtwh+4,7]);
                    }     
             
                    // Charger Board
                    color("cyan") translate(chrgschieber) rotate(chrgdreher) {
                        // Rückseite
                        cube([chrgx,chrgw,chrgz]);
                        translate([-chrgw,0,0]) cube([chrgw,chrgwh,chrgz]);
                        translate([chrgx,0,0]) cube([chrgw,chrgwh,chrgz]);
                        translate([-chrgw,0,chrgz]) cube([chrgx+2*chrgw,chrgwh,chrgw]);
                        
                        // Versteifung
                        translate([chrgx,-2,0]) cube([chrgw,chrgwh+4,7]);
                        translate([-5,-2,0]) cube([5,chrgwh+4,7]);

                        //translate(chrgusbschieber) rotate([0,90,0]) cylinder(d=chrgusbdm,h=20);
                    }
                    
                    // Schraubendings für Verbindung Boden+Turm
                    translate(schraubenschieber1) difference() {
                        cylinder(d=bodenlochschdm,h=bodenlochschh);
                        cylinder(d=bodenlochschdmi,h=bodenlochschh);
                    }             
                    translate(schraubenschieber2) difference() {
                        cylinder(d=bodenlochschdm,h=bodenlochschh);
                        cylinder(d=bodenlochschdmi,h=bodenlochschh);
                    }             
                }
                union() {
                    // Akkuhalter
                    translate(batschieber) rotate(batdreher) {
                        cylinder(d=batdm,h=bath);
                        // Klemme
                        translate([-batsw/2,-batdm/2-batw,10]) cube([batsw,batdm+2*batw+1,bath-10]);
                        // Kabelauslass
                        translate([-batw/2,-batdm/2-batw,0]) cube([2,batdm+2*batw+1,bath]);
                    }

                    // lgt8f board
                    color("red") translate(lgtschieber) rotate(lgtdreher) {
                        // USB-Stecker-Loch
                        translate([lgtx/2,lgtw+3.5,-bodenh]) cylinder(d=lgtusbdm,h=bodenh+1);
         
                        translate([-lgtw,lgtwh-2,lgtz/2]) cube([lgtw,2,5]);
                        translate([lgtx,lgtwh-2,lgtz/2]) cube([lgtw,2,5]);
                        translate([(lgtx-5)/2,0,lgtz]) cube([5,lgtwh,lgtw]);
                    }            

                    // Schraubendings-Loch für Verbindung Boden+Turm
                    translate(schraubenschieber1) {
                        cylinder(d=bodenturmbodm,h=bodenturmbodh);
                    }             
                    translate(schraubenschieber2) {
                        cylinder(d=bodenturmbodm,h=bodenturmbodh);
                    }             

                    // Ladehalter
                    color("red") translate(chrgschieber) rotate(chrgdreher) {
                        translate(chrgusbschieber) rotate([0,90,0]) {
                            cube([12,8,10]);
                            //cylinder(d=chrgusbdm,h=20);
                        }
                        translate([-chrgw,chrgwh-2,chrgz/2]) cube([chrgw,2,5]);
                        translate([chrgx,chrgwh-2,chrgz/2]) cube([chrgw,2,5]);
                        translate([(chrgx-5)/2,0,chrgz]) cube([5,chrgwh,chrgw]);
                    }
                }
            }
            
            // Steckhülse
            color("pink") translate([0,0,turmh-5]) difference() {
                union() {
                    // äußerer Zylinder 
                    cylinder(d=turmdi,h=7);
                    // + Fase
                    translate([0,0,7]) cylinder(d1=turmdi,d2=turmdi-1,h=3);
                }
                union() {
                    // innerer Zylinder
                    translate([0,0,2]) cylinder(d=turmdi-5,h=10);
                    // + Fase
                    translate([0,0,0]) cylinder(d2=turmdi-5,d1=turmdi,h=4);

                    // Schraubverbinderloch Boden+Turm
                    translate(schraubenschieber1) {
                        cylinder(d=bodenturmbodm,h=bodenturmbodh+20);
                    }
                    translate(schraubenschieber2) {
                        cylinder(d=bodenturmbodm,h=bodenturmbodh+20);
                    }      
                    // die Kante für die Strebe im Turm
                    color("lime") {
                        translate([19.4,-35,5]) cube([12,70,5]);
                    }
                }
            }
        }
        union() {
            translate([-turmda/2,-40,0]) cube([69,80,65]);
        }
    }
}

//================================================================================
module turm() {
    // der eingefügte Deckel
    /**/
    intersection() {
        union() {
            difference() {
                union() {
                    difference() {
                        union() {
                            // der äussere Turm
                            cylinder(d=turmda,h=turmho);
                        }
                        union() {
                            // der innere Turmausschnitt
                            cylinder(d=turmdi,h=turmho);
                            // Fase (A)
                            cylinder(d1=turmdi+2,d2=turmdi,h=2);
                        }
                    }
                    // der Deckel
                    translate(deckeltranslate) rotate(deckelrotate) deckel();
                    // Die Haltesteege
                    color("lime") {
                        translate([20,-30,pcbshift+pcbx+2*borderw+pcbdh]) cube([10,60,20]);
                        // Offset entsprechend Fase (A)
                        translate([20,-30,pcbshift-5+2]) cube([10,60,3]);
                        translate([27,-30,pcbshift-5+2-3]) cube([3,60,3]);
                    }
                }
                union() {
                    // Überhang des Turms entfernen
                    translate([0,0,2.30]) translate(deckeltranslate) rotate(deckelrotate) 
                        cube([100,100,100]);
                    // Rundung Rückseite entfernen
                    translate(pcbtranslate) translate([0,0,-pcbshift]) cube([20,60,150]);
                    // Panel entfernen --> Halteknubbellöcher
                    translate(pcbtranslate) rotate([0,-90,0]) pcbbackpanelcut();
                }
            }
        }
        // der äußere Umschnitt
        union() {
            cylinder(d=turmda,h=turmho);
        }
    }
    
    // Schraubendings für Verbindung Boden+Turm für M3-Blindniete
    translate(schraubenschieber1) translate([0,0,6]) difference() {
        cylinder(d=bodenturmthdm,h=bodenturmth);
        cylinder(d=bodenturmBlindndm,h=bodenturmth);
    }             
    translate(schraubenschieber2) translate([0,0,6]) difference() {
        cylinder(d=bodenturmthdm,h=bodenturmth);
        cylinder(d=bodenturmBlindndm,h=bodenturmth);
    }             

    /** /
    // der Freiplatzhalter
    translate(pcbtranslate) rotate([0,-90,0]) pcbbackpanelcut();
    /**/
    // Das Panel
    // translate(pcbtranslate) rotate([0,-90,0]) pcbbackpanel();
    /**/
}

//================================================================================
module tasterloch(ofs) {
    translate([0,0,ofs-0.2]) cylinder(d=TSlochdm+0.3,h=0.2);            
    cylinder(d=TSlochdm,h=20);            
}

//================================================================================
module deckel() {
    difference() {
        union() {
            color("brown") cube([deckelx,deckely,deckelh]);
            dreh = [3,2,4,1];
            for (i=[-1:2:1]) {
                for (j=[-1:2:1]) {
                    translate([deckelx/2+i*deckelblx/2+deckeldispofs,deckely/2+j*deckelbly/2,-deckeldisth]) {
                        color("white") ringstand(deckeloleddm+4,deckeloleddm,deckeldisth,
                            dreh[(i+1)+(j+1)/2]);
                    }
                }
            }                
        }
        union() {
            // Bohrlöcher
            for (i=[-1:2:1]) {
                for (j=[-1:2:1]) {
                    translate([deckelx/2+i*deckelblx/2+deckeldispofs,deckely/2+j*deckelbly/2,0]) {
                        cylinder(d=deckeloleddm,h=deckelh);
                    }
                }
            }                
            // Deckelloch
            translate([deckelx/2-deckelsfx/2+deckeldispofs,deckely/2-deckelsfy/2,0]) 
                cube([deckelsfx,deckelsfy,deckelh]);
            translate([deckelx/2-deckelsfx/2+deckeldispofs-3,deckely/2-deckelsfy/2-3,0]) 
                cube([deckelsfx+6,deckelsfy+6,1]);
            // die Tasterlöcher
            translate([deckelswitchofs,0,0]) {
                translate(TSpos1) tasterloch(deckelh);
                translate(TSpos2) tasterloch(deckelh);
                translate(TSpos3) tasterloch(deckelh);
            }
        }
    }
    
    // Tasterrahmen
    translate([deckelswitchofs,0,0]) {
        translate(TSpos1) tasterhalterung(0);
        translate(TSpos2) tasterhalterung(0);
        // Ein/Aus
        translate(TSpos3) tasterhalterung(1); 
    }
}

//================================================================================
module tasterhalterung(s) {  // small
    dx = (s==1) ? 8.15 : 8.65;
    dy = (s==1) ? 8.15 : 8.65;
    w = 1;
    dh = 10;
    dhi = 8;
    dwr = 2;
    
    translate([(-dx-2*w)/2,(-dy-2*w)/2,-dh]) {
        difference() {
            cube([dx+2*w,dy+2*w,dh]);
            translate([w,w,0]) cube([dx,dy,dh]);
        }
        for (i=[0:1]) {
            for (j=[0:1]) {
                translate([w+i*(dx),w+j*(dy),dh-dhi]) {
                    cylinder(d=dwr,h=dhi);
                }
            }
        }                
    }
}

//================================================================================
module pcbbackpanelcut() {
    translate([0,0,0]) cube([pcbx+pcbdh+2*borderw,pcby+2*borderw,pcbh+24]);
    // die Verbindungs-Locks
    color("white") {
        translate([0,bpanelofs,borderh/2]) sphere(d=bpanellock);
        translate([0,2*borderw + pcby - bpanelofs,borderh/2]) sphere(d=bpanellock);
        translate([2*borderw+pcbx+pcbdh,bpanelofs,borderh/2]) sphere(d=bpanellock);
        translate([2*borderw+pcbx+pcbdh,2*borderw + pcby - bpanelofs,borderh/2]) sphere(d=bpanellock);
    }
}

//================================================================================
module pcbbackpanel() {
    difference() {
        union() {
            translate([borderw,borderw,0]) cube([pcbx+pcbdh,pcby,pcbh]);
            color("blue") {
                // schräg gestellt zum reindrehen
                cube([borderw, 2*borderw + pcby, 1]);
                translate([0,0,1]) rotate([0,10,0]) cube([borderw, 2*borderw + pcby, borderh-1]);
                // oben
                translate([borderw+pcbx+pcbdh,0,0]) cube([borderw, 2*borderw + pcby, borderh]);
                
                // seitlich etwas kürzer wg. Schräge
                dk = 1.0;
                translate([dk,0,0]) {
                    cube([2*borderw+pcbx+pcbdh-dk, borderw, borderh]);
                    translate([0,borderw+pcby,0]) cube([2*borderw+pcbx+pcbdh-dk, borderw, borderh]);
                }
            }
            color("green") translate([borderw,borderw,0]) {
                translate([pcbx/2.0-bohrx/2.0,pcby/2.0-bohry/2.0,pcbh]) ringstand(standdm,bohrdm,standh,3);
                translate([pcbx/2.0-bohrx/2.0,pcby/2.0+bohry/2.0,pcbh]) ringstand(standdm,bohrdm,standh,2);
                translate([pcbx/2.0+bohrx/2.0,pcby/2.0-bohry/2.0,pcbh]) ringstand(standdm,bohrdm,standh,4);
                translate([pcbx/2.0+bohrx/2.0,pcby/2.0+bohry/2.0,pcbh]) ringstand(standdm,bohrdm,standh,1);
            }
            // die Verbindungs-Locks
            color("white") {
                // etwas reinversetzt und kleiner
                kk = 0.3;
                translate([1.3,bpanelofs,borderh/2]) sphere(d=bpanellock-kk);
                translate([1.3,2*borderw + pcby - bpanelofs,borderh/2]) sphere(d=bpanellock-kk);
                translate([2*borderw+pcbx+pcbdh-1,bpanelofs,borderh/2]) sphere(d=bpanellock-kk);
                translate([2*borderw+pcbx+pcbdh-1,2*borderw + pcby - bpanelofs,borderh/2]) sphere(d=bpanellock-kk);
            }
        }
        union() {
            translate([borderw,borderw,0]) {
                translate([pcbx/2.0-bohrx/2.0,pcby/2.0-bohry/2.0,-3]) cylinder(h=10,d=bohrdm);
                translate([pcbx/2.0-bohrx/2.0,pcby/2.0+bohry/2.0,-3]) cylinder(h=10,d=bohrdm);
                translate([pcbx/2.0+bohrx/2.0,pcby/2.0-bohry/2.0,-3]) cylinder(h=10,d=bohrdm);
                translate([pcbx/2.0+bohrx/2.0,pcby/2.0+bohry/2.0,-3]) cylinder(h=10,d=bohrdm);
            }
            
            dx = 4;
            dy = 4;
            rr = 1;
            translate([10,8,0]) 
                for (i = [0:10]) {
                    for (j = [0:7]) {
                        translate([i*(dx+rr),j*(dy+rr),0]) cube([dx,dy,pcbh]);
                    }
                }
        }
    }
}

//================================================================================
module ringstand(da, di, ho, q) {
    /*
        0: vollrohr
        1,2,3,4: entsprechende viertel    

translate([0,0,0]) ringstand(10,5,20,0);
translate([12,0,0]) ringstand(10,5,20,1);
translate([24,0,0]) ringstand(10,5,20,2);
translate([36,0,0]) ringstand(10,5,20,3);
translate([48,0,0]) ringstand(10,5,20,4);

    */
    if (q==0) {
        difference() {
            cylinder(d=da,h=ho);
            cylinder(d=di,h=ho);
        }
    } else {
        ar = [0,0,90,180,270];
        rotate([0,0,ar[q]])
        difference() {
            union() {
                rotate_extrude(angle=90) square([da/2,ho]);
                rotate([0,0,180]) translate([-(da)/2-1,-(da)/2-1,0]) cube([da/2+1,da/2+1,ho]);
            }
            union() {
                rotate_extrude(angle=90) square([di/2,ho]);
            }
        }
    }
}





//

