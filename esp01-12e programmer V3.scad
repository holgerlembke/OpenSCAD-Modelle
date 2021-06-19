/*
   ESP01-12e/f Modul Programmierer
   
   Inkarnation #3

*/


$fn = $preview ? 20 : 100;

include <MCAD/boxes.scad>
use <ESP8266Models.scad>


pind = 1.45;
pinh=13.3;

spacerh = 2.1;


difference() {
    koerper();

    pogopins();
    stufe();
}
//pogopins();
//stufe();
//wemos();


//===========================================================
module koerper() {
    stuetzen();
    translate([-9.0,-7.0,0.0])
    cube([18.0,17.0,pinh]);
}


//===========================================================
module stufe() {
    color("blue") {
        translate([9.0-6.0,-27.0,0.0])
        cube([6.0,40.0,4.0]);

        translate([-9.0,-27.0,0.0])
        cube([6.0,40.0,4.0]);
    }

    color("red") {
        translate([9.0-5.0,-27.0,6.8])
        cube([5.0,40.0,2.5]);

        translate([-9.0,-27.0,6.8])
        cube([5.0,40.0,2.5]);
    }
}

//===========================================================
module stuetzen() {
    color("green") {
        for (x=[-1:2:1]) {
            for (y=[-1:2:1]) {
                translate([(3*x),1.4+(4*y),pinh])
                cylinder(d=3.0,h=spacerh);
            }
        }
    }
}

//===========================================================
module pogopins() {
    for (i=[0:7]) {
        for (j=[-1:2:1]) {
            // etwas schief stellen
            translate([-7.1*j,i*2-5.4,-10])
            rotate([0.0,j*0.5,0.0])
            cylinder(d=pind,h=42.8);
        }
    }
}

//===========================================================
module wemos() {
    WemosD1M(pins=3);
}
