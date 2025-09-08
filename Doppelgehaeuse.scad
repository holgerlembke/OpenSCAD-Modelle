/*
    Doppelgehäuse
    
    USB-Netzteil + Zeugs
    
*/

$fn = $preview ? 20 : 200;

// relais-Board: 60x65x24

wands = 2.0;                     // Wandstärke
innenb = 60.0;                  // Innenbreite
innenl = 65.0;                   // Innenlänge

hoeheHV = 20.0;              // Höhe des HV/USB-Netzeil
hoeheLV = 30.0;               // Höhe des NV/Zeugs

zapfHV = 5.0;
zapfLV = 10.0;

zapfdelta = 0.2;                // Sorgt für Luft in den Zapfen

schraubzapfen = 2;          // 0, 2, 4
schraubdma = 5.5;
schraubdmi = 3.3;
schraubh = 9;

luftldm = 3.0;                   // Durchmesser des Luftlochs
luftlrz = 2;                        // Reihen für das Luftloch
luftlrzn = 2;



gehaeuseHV(0) ;
translate([0,-innenl-10,0]) gehaeuseLV(0) ;
translate([70,-35,0]) Trennwand();

// Ladegerät-Simulation
//color("black") translate([82,-20,0]) cube([40,55,18]);



//==============================================
module Trennwand() { // 
    difference() {
        union() {
            color("cyan") translate([-wands,-wands,0]) { 
                cube([innenb+2*wands,innenl+2*wands,wands]);
                translate([45,5,0])
                    cube([wands,20,18]);
                translate([45,45,0])
                    cube([wands,20,18]);
            }
        }
        union() {
            translate([0,0,-hoeheHV]) 
                gehaeuseHV(zapfdelta);
            translate([0,0,-hoeheLV]) 
                gehaeuseLV(zapfdelta);
        }
    }
}

//==============================================
module gehaeuseHV(cutdelta) { // High Voltage
    difference() {
        union() {
            color("red") cube([innenb,innenl,wands]);
            // Wände
            translate([0,-wands,0]) 
                cube([innenb,wands,hoeheHV]);
            translate([0,innenl,0]) 
                cube([innenb,wands,hoeheHV]);
            translate([-wands,-wands,0]) 
                cube([wands,innenl+2*wands,hoeheHV]);
            translate([innenb,-wands,0]) 
                cube([wands,innenl+2*wands,hoeheHV]);
            
            translate([0,0,hoeheHV]) {
                translate([-wands,innenl,0]) 
                    cube([zapfHV+cutdelta,wands,wands]);
                translate([-wands,innenl-zapfHV+wands-cutdelta,0]) 
                    cube([wands,zapfHV+cutdelta,wands]);
                translate([-wands,-wands,0]) 
                    cube([zapfHV+cutdelta,wands,wands]);
                translate([-wands,-wands,0]) 
                    cube([wands,zapfHV+cutdelta,wands]);
                translate([-zapfHV+innenb+wands-cutdelta,innenl,0]) 
                    cube([zapfHV+cutdelta,wands,wands]);
                translate([innenb,innenl-zapfHV+wands-cutdelta,0]) 
                    cube([wands,zapfHV+cutdelta,wands]);
                translate([-zapfHV+innenb+wands-cutdelta,-wands,0])     
                    cube([zapfHV+cutdelta,wands,wands]);
                translate([innenb,-wands,0]) 
                    cube([wands,zapfHV+cutdelta,wands]);
            }
        }
        union() {
            luftloecher();
        }
    }
    translate([0,0,hoeheHV]) {
        schraubenconnector();
    }
}

//==============================================
module gehaeuseLV(cutdelta) { // Low Voltage
    difference() {
        union() {
            color("green") cube([innenb,innenl,wands]);
            // Wände
            translate([0,-wands,0]) 
                cube([innenb,wands,hoeheLV]);
            translate([0,innenl,0]) 
                cube([innenb,wands,hoeheLV]);
            translate([-wands,-wands,0]) 
                cube([wands,innenl+2*wands,hoeheLV]);
            translate([innenb,-wands,0]) 
                cube([wands,innenl+2*wands,hoeheLV]);
            
            translate([0,0,hoeheLV]) {
                translate([-wands,-wands+(innenl-zapfLV-cutdelta+2*wands)/2,0]) 
                    cube([wands,zapfLV+cutdelta,wands]);
                translate([innenb,-wands+(innenl-zapfLV-cutdelta+2*wands)/2,0]) 
                    cube([wands,zapfLV+cutdelta,wands]);

                translate([-wands+(innenb-zapfLV-cutdelta+2*wands)/2,-wands,0]) 
                    cube([zapfLV+cutdelta,wands,wands]);
                translate([-wands+(innenb-zapfLV-cutdelta+2*wands)/2,+innenl,0]) 
                    cube([zapfLV+cutdelta,wands,wands]);
            }
        }
        union() {
            luftloecher();
        }
    }
    translate([0,0,hoeheLV+wands]) {
        schraubenconnector();
    }
}

//==============================================
module luftloecher() {
    // entlang langer Seite/innenb
    idx = luftldm+2;
    ix = floor(innenb/idx);
    ixofs = (innenb-idx*(ix-1))/2;
    
    dn = 7.5;
    
    for (n1=[0:luftlrzn-1]) {
        for (i=[0:ix-1]) {
            translate([ixofs+i*idx,2,wands+luftldm/2+n1*dn]) rotate([90,0,0]) 
                cylinder(d=luftldm,h=6);
            translate([ixofs+i*idx,innenl+3,wands+luftldm/2+n1*dn]) rotate([90,0,0]) 
                cylinder(d=luftldm,h=6);
        }
        if (luftlrz==2) {
            ixofs=ixofs+luftldm/2+1;
            ix=ix-1;
            for (i=[0:ix-1]) {
                translate([ixofs+i*idx,2,wands+luftldm+2+n1*dn]) rotate([90,0,0]) 
                    cylinder(d=luftldm,h=6);
                translate([ixofs+i*idx,innenl+3,wands+luftldm+2+n1*dn]) rotate([90,0,0]) 
                    cylinder(d=luftldm,h=6);
            }
        }
    }
    
    // entlang kurzer Seite/innenl
    idy = luftldm+2;
    iy = floor(innenl/idy);
    iyofs = (innenl-idy*(iy-1))/2;
    
    for (n1=[0:luftlrzn-1]) {
        for (i=[0:iy-1]) {
            translate([-2-wands,iyofs+i*idy,wands+luftldm/2+n1*dn]) rotate([-0,90,0]) 
                cylinder(d=luftldm,h=6);
            translate([innenb-wands,iyofs+i*idy,wands+luftldm/2+n1*dn]) rotate([-0,90,0]) 
                cylinder(d=luftldm,h=6);
        }
        if (luftlrz==2) {
            iyofs=iyofs+luftldm/2+1;
            iy=iy-1;
            for (i=[0:iy-1]) {
                translate([-2-wands,iyofs+i*idy,wands+luftldm+2+n1*dn]) rotate([-0,90,0]) 
                    cylinder(d=luftldm,h=6);
                translate([innenb-wands,iyofs+i*idy,wands+luftldm+2+n1*dn]) rotate([-0,90,0]) 
                    cylinder(d=luftldm,h=6);
            }
        }
    }
}

//==============================================
module schraubenconnector() {
    if (schraubzapfen!=0) {
        if (schraubzapfen>=2) {
            translate([-schraubdma-wands,innenl/2,-schraubh]) rotate([0,0,-90]) 
                schraubzapfen();                    
            translate([innenb+wands+schraubdma,innenl/2,-schraubh]) rotate([0,0,90]) 
                schraubzapfen();                    
        }
        if (schraubzapfen>=4) {
            translate([innenb/2,innenl+wands+schraubdma,-schraubh]) rotate([0,0,-180]) 
                schraubzapfen();                    
            translate([innenb/2,-schraubdma-wands,-schraubh]) rotate([0,0,]) 
                schraubzapfen();                    
        }
    }
}

//==============================================
module schraubzapfen() {
    color("gray") difference() {
        union() {
            cylinder(d=schraubdma,h=schraubh);
            translate([-schraubdma/2,0,0]) cube([schraubdma,schraubdma,schraubh]);
        }
        union() {
            cylinder(d=schraubdmi,h=schraubh);
        }
    }
}
        
   

//