/*

  Modularer Gelenkarmkrams



 */

$fn = $preview ? 20 : 120; // hier ändern für schnelleres Rendern

/*
color("black") {
    translate([50,-20,0]) cube([1,80,10]);
    translate([-51,-20,0]) cube([1,80,10]);
    translate([0,-20,0]) cube([100,1,10],center=true);
}
*/
translate([0,115,0]) {
    translate([45,-35,0]) rotate([0,0,90]) gelenkarm(100,9,9,3.5,3.5,false,3,2);
    translate([0,11,0]) rotate([0,0,180]) gelenkarm(100,9,9,3.5,3.5,true,-2,-3);
}
translate([0,22,0]) gelenkarm(100,9,9,3.5,3.5,false,3,-3);
translate([-45,68,0]) rotate([0,0,90]) gelenkarm(100,9,9,3.5,3.5,true,-3,3);
//translate([0,65,0]) gelenkarm(50,20,20,12,14,true,-7,-4);

/*



*/
//*********************************************************************************************************
module gelenkarm(
    laenge, breite, hoehe,
    lochdmA,
    lochdmB,
    neunzig,  // B-Ende um 90 Grad drehen
    slotsA,    // >1: Anzahl der Stege, <1: passt zur >1-Variante
    slotsB
    ) {
    slotfree = 1;        // Platz nach hinten
    slotspace = 0.4;   // Slotvergrößerung
    rundung = 1.0;
    
    difference() {
        // Vollkörper
        union() {
            //  AA
            translate([-laenge/2+breite/2.0,0,-hoehe/2]) cylinder(h=hoehe,d=breite);
            // BB
            if (neunzig) { // gedreht
                color("green") {
                    translate([-(hoehe-breite)/4.0,0,0])
                    roundcube(laenge-(breite+hoehe)/2.0,breite,hoehe,rundung);
                }
                translate([+laenge/2-hoehe/2,breite/2,0]) rotate([90,0,0]) 
                union() {
                    cylinder(h=breite,d=hoehe);
                }
            } else {
                union() {
                    color("red") {
                        roundcube(laenge-breite,breite,hoehe,rundung);
                    }
                    translate([+laenge/2-breite/2.0,0,-hoehe/2]) 
                    union() {
                        cylinder(h=hoehe,d=breite);
                    }
                }
            }
        }
        // Abziehen
        union() {
            // Die Schraubenlöcher
            union() {
                // AA
                translate([-laenge/2+breite/2.0,0,-hoehe/2]) 
                cylinder(h=hoehe,d=lochdmA);
                // BB
                if (neunzig) { // gedreht
                    translate([+laenge/2-hoehe/2,breite/2,0]) 
                    rotate([90,0,0])
                    cylinder(h=breite,d=lochdmB);
                } else {
                    translate([laenge/2-breite/2.0,0,-hoehe/2]) 
                    cylinder(h=hoehe,d=lochdmB);
                }
            }
            
            // AA
            translate([-laenge/2+breite,0,-hoehe/2])  {
                if (slotsA!=0) {
                    slotter = abs(slotsA);
                    tslots=slotter*2-1;
                    dh = hoehe/(tslots);
                    ofs = (slotsA>0) ? dh : 0;  // Mehr platz nach innen
                    ofsu =(slotsA<0)? slotspace/2.0 : 0;
                    for (i=[0:tslots]) {
                        if (i%2==0) {
                            translate([-breite,-breite/2,dh*i+ofs-ofsu]) {
                                cube([breite+slotfree,breite,dh+ofsu*2.0]);
                            }
                        }
                    }        
                }
            }
            
            // BB
            if (neunzig) { // gedreht
                rotate([90,0,0])
                translate([+laenge/2,0,-breite/2])  {
                    if (slotsB!=0) {
                        slotter = abs(slotsB);
                        tslots=slotter*2-1;
                        dh = breite/(tslots);
                        ofs = (slotsB>0) ? dh : 0;  // Mehr platz nach innen
                        ofsu =(slotsB<0)? slotspace/2.0 : 0;
                        for (i=[0:tslots]) {
                            if (i%2==0) {
                                translate([-hoehe-slotfree,-hoehe/2,dh*i+ofs-ofsu]) {
                                    cube([hoehe+slotfree,hoehe,dh+ofsu*2.0]);
                                }
                            }
                        }        
                    }
                }
            } else {
                translate([+laenge/2,0,-hoehe/2])  {
                    if (slotsB!=0) {
                        slotter = abs(slotsB);
                        tslots=slotter*2-1;
                        dh = hoehe/(tslots);
                        ofs = (slotsB>0) ? dh : 0;  // Mehr platz nach innen
                        ofsu =(slotsB<0)? slotspace/2.0 : 0;
                        for (i=[0:tslots]) {
                            if (i%2==0) {
                                translate([-breite-slotfree,-breite/2,dh*i+ofs-ofsu]) {
                                    cube([breite+slotfree,breite,dh+ofsu*2.0]);
                                }
                            }
                        }        
                    }
                }
            }
        }
    }
}


//*********************************************************************************************************
module roundcube(laenge, breite, hoehe, radius) {
    translate([-laenge/2.0,breite/2.0-radius,hoehe/2.0-radius]) rotate([0,90,0]) cylinder(h=laenge,r=radius);
    translate([-laenge/2.0,breite/2.0-radius,-hoehe/2.0+radius]) rotate([0,90,0]) cylinder(h=laenge,r=radius);
    translate([-laenge/2.0,-breite/2.0+radius,hoehe/2.0-radius]) rotate([0,90,0]) cylinder(h=laenge,r=radius);
    translate([-laenge/2.0,-breite/2.0+radius,-hoehe/2.0+radius]) rotate([0,90,0]) cylinder(h=laenge,r=radius);
    cube([laenge,breite,hoehe-2*radius],center=true);
    cube([laenge,breite-2*radius,hoehe],center=true);
}


