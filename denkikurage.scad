/*
    denki-kurage 
    
    Rundes Gehäuse
    
    Mehr oder weniger (eher mehr) ein großes Desaster,
    da der PCB-Designer des runden Displays einen
    vergleichsweise gro0ßen rechteckigen 1/10" Pin-Kopf
    andesignt hat. Der braucht viel Platz.
    
    Dumme Idee.

    Suchbegriff: 1.53 Inch round ST77916 qspi tft
*/

$fn = $preview ? 20 : 200;

didm = 42.0;      // Display Durchmesser

// Torus
tda = 50.0;       // Aussendurchmesser  
tdi = 45.0;       // Innendurchmesser
ttdm = 35.0;      // Torus-Radius
twi = 35;         // Winkel

// Deckel
ddi = 38.0;       // Deckelloch für TFT
ddh = 3.0;        // - höhe

// Zylinder
cylena = 34.0;
cyleni = 32.0;
cyda = 8.0;
cydi = 7.0;
cyofsx = 9.5;
cyofsy = 2.16;

//schnitt();
zusammenbau();
// bodendeckel();

  
//===================================================================
module bodendeckel() {
  difference() {
    union() {
      translate([ttdm,-0.9,0])
        rotate([-90,0,0])
          cylinder(d=tda-0.12,h=2);
    }
    union() {
      scale([1.005,1.005,1])
        zusammenbau();
      // vorne freischneiden
      translate([5,0,-15])
        cube([10,3,30]);
    }
  }
  
  s3b = 19;
  s3l = 24;
  color("red")
  translate([ttdm+tdi-s3l,0.8,s3b/2])
    rotate([-90,90,0]) {
      difference() {
        translate([-2,2,0])
          cube([s3b+4,s3l+1,2]);
        s3zero();
      }
    }
}  

//===================================================================
module schnitt() {
  intersection() {
    zusammenbau();
    translate([-100,-100,0])
    cube([200,200,200]);
  } 
}

//===================================================================
module zusammenbau() {
  intersection() {
    zusammenbau2();
    translate([0,-80,-40])
      cube([80,80,80]);
  }
}

//===================================================================
module zusammenbau2() {
  // wg. druck auf der Stirnfläche
  rotate([0,0,-twi]) {
    difference() {
      union() {
        difference() {
          union() {
            torus(tda,0);
            deltax = 0.2;
            deltay = 0.1;
            for (i=[0:15]) {
              rotate([0,0,10]) 
                translate([i*deltax,i*deltay-1.4,0]) {
                  translate([cyofsx,cyofsy,-cylena/2])
                    cylinder(d=cyda,h=cylena);
                  // Abscluß links/rechts
                  color("pink") translate([0,0,0]) {
                    translate([cyofsx,cyofsy,cylena/2])
                      sphere(d=cyda);
                    translate([cyofsx,cyofsy,-cylena/2])
                      sphere(d=cyda);
                  }
                }
            }
          }
          union() {
            torus(tdi,1);
          }
        }
        // Deckel
        color ("green")
          rotate([90,0,twi])
            translate([ttdm,0,0])
              deckel();
/*        
        // Füllrechteck 
        cyleni2=cyleni+0.4;
        blen = 4;
        color("cyan") 
          translate([cyofsx-2,2.5,-cyleni2/2]) {
            cube([8,cydi/2+1,blen]);
            translate([0,0,cyleni2-blen])
              cube([8,cydi/2+1,blen]);
            cube([4,cydi/2+1,cyleni2]);
          }
*/          
      }
      union() {
        color ("blue")
        translate([cyofsx,cyofsy,-cyleni/2])
          cylinder(d=cydi,h=cyleni);
        // Ausschnitt für PCB
        color("cyan") 
          translate([cyofsx,3,-cyleni/2])
            cube([15,cydi/2,cyleni]);
        color("cyan") 
          translate([cyofsx+1,-0.8,-cyleni/2])
            rotate([0,0,twi])
              cube([18,cydi/2+2.6,cyleni]);
        // der USB-Stecker-Ausschnitt
        slb = 10;
        translate([50,0,-slb/2])
          cube([20,9,slb]);
      }
    }
  } 
}

//===================================================================
module deckel() {
  difference() {
    union() {
      cylinder(d1=tda,d2=tdi,h=ddh);
    }
    union() {
      cylinder(d=ddi,h=ddh);
      translate([0,0,ddh-2.6])
        cylinder(d=didm,h=ddh);
    }
  }
}

//===================================================================
module torus(dd, wi) {
  rotate_extrude(angle = twi+wi, convexity=2)
    translate([ttdm, 0, 0])
      circle(d=dd);
}

//===================================================================
module s3zero() {
  // sizes are generous
  cube([19,24,3]);
  translate([(19-9.6)/2,-1,3])
    cube([9.6,8,3.6]);
}






