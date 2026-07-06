/*
    Nebula-Display-Drehscheibe V2
    
    benötigt 
    -- 3 x (M3x16 + 2 x M3 Scheibe + M3 Mutter)
    -- M3x10 Abstandhalter
    -- M3x30 Schraube
    
    m3x30-Schraube in Anbauteil einkleben.
    
    Zum Einlegen des Abstandhalters den
    Druck an entsprechender Stelle anhalten.
    
    Bei Klipper: PAUSE-Makro einfügen    
*/

$fn = $preview ? 20 : 300;


// Schraubenlöcher

dd1 = (24.4+15.2) / 2.0;
dd2 = (44.4+35.2) / 2.0;
dd3 = (11.8+19.7) / 2.0;
ddh = 7;
ddmi = 4.5;
ddma = 15;

// Schraubenloch Druckerseite
ddsm = 8;
ddsh = 3;

// Schraube Drehgriff
ddgm = 3.5;
ddgkm = 7.0;
ddgh = 3.0;

ddl = [35,35,0];
ddlo = 20;

// Slots in Modulseite
slt = 3.5;
slb = 1.2;
sll = 28.0;
slyofs = 6.0;       // Abstand zwischen den Löchern
slxofs = 3.0-0.45;  // Abstand zwischen den Slots

druckerhebel = [
  [-6,-4],[-6,dd2],[4,dd2],[dd1,4],[dd1,-4]
];

// Drehgriff
dgdm = 11.5;
dgl = 77.0;
// Drehgriff-Griffseite
dggsdm = 30.0;
dggsl = 12.0;

dgsll = 50.0;
dgshx = 7.0;   // Abstand der Hex-Nut vom Ende
dgshxl = 11.0;  // Länge der Hex-Nut

// Darstellung
/**/
hebeldruckerseite();
translate([20,10,30])
  modulseite();
translate([20,25,140])
  rotate([180,0,0]) 
    drehgriff();
/**/

// hebeldruckerseite();
// modulseite();
// drehgriff();

//***********************************************************
module drehgriff() {
  color("green")
  difference() {
    union() {
      cylinder(d=dggsdm,h=dggsl);
      translate([0,0,dggsl])
        cylinder(d=dgdm,h=dgl);
    }
    union() {
      // Schraubenloch
      translate([0,0,dggsl+dgl-dgsll]) 
        cylinder(d=3.5,h=dgsll);
      translate([0,0,dggsl+dgl-dgshx-dgshxl])
        hex_nut(5.5,dgshxl);  
      
      
      // Griffraster
      for (x=[0:5]) 
        rotate([0,0,60*x])
          translate([0,21,0])
            cylinder(d=18,h=dggsl+10);
    }
  }
}

//***********************************************************
// M3: 5.5, M2: 4.0
module hex_nut(width, height, center=false) {
    cylinder(r=(width/sin(60)/2), h=height, center=center, $fn=6);
}  

//***********************************************************
module modulseite() {
  color("red") 
  difference() {
    basisplatte();
    union() {
      lochmuster(ddsm,ddsh);
        
      translate([-slb/2,slyofs,ddh-slt]) {
        translate([-slxofs,0,0])
          cube([slb,sll,slt]);  
        translate([slxofs,0,0])
          cube([slb,sll,slt]);  
      }        
    }
  }
}

//***********************************************************
module hebeldruckerseite() {
  color("lightblue") 
  difference() {
    union() {
      basisplatte();
      translate([20,20,0])
        cylinder(d=20,h=ddh);
    }
    union() {
      translate([0,0,ddh-ddsh])
        lochmuster(ddsm,ddsh);
      translate([20,20,0]) {
        cylinder(d=ddgkm,h=ddgh);
        cylinder(d=ddgm,h=ddh);
      }
    }
  }
}

//***********************************************************
module basisplatte() {
  difference() {
    union() {
      lochmuster(ddma,ddh);
      
      linear_extrude(height=ddh)
        polygon(druckerhebel);
    }
    union() {
      lochmuster(ddmi,ddh);
      translate(ddl)
        cylinder(d=ddlo,h=ddh);
      translate([0,dd3,0]) {
        cylinder(d=ddgm,h=ddh);
      }
    }
  }
}


//***********************************************************
module lochmuster(dx, hx) {
  cylinder(d=dx,h=hx);
  translate([dd1,0,0]) 
    cylinder(d=dx,h=hx);
  translate([0,dd2,0]) 
    cylinder(d=dx,h=hx);
}


//***********************************************************
module nietmutterM3(endlos) { // endlos==1
  //M3-Blindniete
  ndia = 4.9; // Aussendurchmesser
  ndias = 8.3; // Aussendurchmesser der Kante
  ntiefeg = 10.2;
  ntiefes = 1.0;
  
  if (endlos==1) {
    translate([0,0,-100])
    cylinder(d=ndias,h=100+ntiefes);
    cylinder(d=ndia,h=ntiefeg+100);  
  } else {
    cylinder(d=ndias,h=ntiefes);
    cylinder(d=ndia,h=ntiefeg);  
  }
}    
    

