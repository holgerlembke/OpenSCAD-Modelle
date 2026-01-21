/*
    Billig LED Steckdosenleuchte Deckel
    
    gedruckt mit 0.1 schichtdicke
    
*/

$fn = $preview ? 20 : 200;

innen = (61.9+61.7)/2-0.5-0.1-0.05;
aussen = (63.5+63.8)/2;

// Rundungsradius. Is so.
rd = 20.0;

// Dicke der Frontplatte. Anpassen, minimal 0.2 (2 Schichten)
dh = 0.3;      


 //hilfskreuz();

difference() {
  union() {
    frame(-1,1);
    color("blue") translate([0,0,1]) frame(0,4);
  }
  union() {
    color("green") translate([0,0,dh]) frame(1,7);
  }
}


module frame(dd,hh) {
  difference() {
    union() {
      // Rundung
      translate([+dd/2,+dd/2,0]) 
        cylinder(d=rd-dd,h=hh);
      translate([innen-rd-dd/2,+dd/2,0]) 
        cylinder(d=rd-dd,h=hh);
      translate([+dd/2,innen-rd-dd/2,0]) 
        cylinder(d=rd-dd,h=hh);
      translate([innen-rd-dd/2,innen-rd-dd/2,0]) 
        cylinder(d=rd-dd,h=hh);
      // Füllung
      translate([-(rd)/2+dd,0,0]) 
        cube([innen-2*dd,innen-rd-dd,hh]);
      translate([0,-(rd)/2+dd,0]) 
        cube([innen-rd-dd,innen-2*dd,hh]);
    }
    union() {
    }
  }
}

module hilfskreuz() {
  color("red") 
    translate([-rd/2,7,0]) 
      cube([innen,2,2]);

  color("red") 
    translate([rd/2+2,-rd/2,0]) 
      cube([2,innen,2]);
}

