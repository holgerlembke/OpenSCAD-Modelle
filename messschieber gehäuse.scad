// Messschieber Superkondensator  Gehäuse

// USB-B-Stecker
usl = 13.6;
usb = 17.0;
ush = 11.0;

// Deckeldicke
gdd = 3.0;    
// Gehäusehöhe
gh = usl-1.5;
// Gehäusewanddicke
gwd = 3.0;
// Gehäusegesamtlänge
ggl = 41.0;
// Gehäusegesamtbreite
ggb = 25.0;

// Schraubenabsatz Länge und Breite
sal = 9.0;
sab = 6.0;

//----------------------------------------
rotate([180,0,0]) {
    difference() {
        cube([ggl,ggb,gh+gdd]);
        
        //schnittebene();
        loecher();    
    }
    
}

//----------------------------------------
module schnittebene() {
    color("blue")
    translate([-50.0,-50.0,10.0])
    cube([100.0,100.0,100.0]);
}

//----------------------------------------
module loecher() {
    // Schraubenabsatz
    translate([0.0,ggb-sab,0.0])
    cube([sal,sab,gh+gdd+1]);
   
    // USB-Stecker
    translate([gwd,0.0,-1.5])
    cube([ush,usb,usl]);
    
    // Gehäuseausschnitt
    translate([sal+gwd,gwd,0.0])
    cube([ggl-sal-gwd*2.0,ggb-gwd*2.0,gh]);    
        
    // Kabellöcher
    translate([5.0,usb+8.0,0.0])
    rotate([0.0,0.0,-25.0])
    cube([20.0,2.0,3.0]);    
    /*
    translate([ggl-gwd-1,ggb/2.0-3.0,0.0])
    cube([10.0,2.0,2.0]);    
    translate([ggl-gwd-1,ggb/2.0+3.0,0.0])
    cube([10.0,2.0,2.0]);
    */
}




