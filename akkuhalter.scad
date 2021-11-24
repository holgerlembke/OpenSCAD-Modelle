/*
      AA/AAA/18650 Batterieaufbewahrungsbehälter
     
      Eigentlich eher ein anreihbares Blockkonzept zur Verwendung als Objektträger.
      Modulares Konzept: Basisblock nehmen und mit Löchern versehen. Alles
      parametrisiert.
      
      Batterieformate:
      AA        Ø 14,5 mm × 50,5 mm
      AAA      Ø 10,5 mm × 44,5 mm
      18650   Ø 18,6 mm × 65,2 mm
      
      Modulnamen:          Kapazität
        batterieAAA();         5 Stück
        batterieAA();           4 Stück
        batterie18650();      2 Stück
        
      STLs einzeln für die Akkus erzeugen und entsprechend oft 
      auf die Druckplattform/Slicer kopieren und ausdrucken.
      
      "blockhalterdelta" legt die Enge der Verbindung zwischen den Blöcken fest. Der
      Wert kann vorsichtig reduziert werden, der Verbund wird dann fester.
      Alternativ: Fest verbinden mit einem Tropfen Sekundenkleber.
      
      20% Füllung sind ausreichend. Keine Stützstruktur (wg. Fase).

      Designkonzept inspirirt von https://www.thingiverse.com/thing:2354044
      
      Blockbreite
      37.0      wenn 18650 benötigt wird
      35.0      wenn nur AA & AAA benötigt wird      
*/

$fn = $preview ? 20 : 100;   // hier ändern für schnelleres Rendern

blockbreite = 37.0; 
blockhoehe = 25.0;
blockrundung = 5.0; // radius
blockboden = 1.0;
blockbodenrundung = 2.0; // radius

blockhalterrundung = 2.5; // radius
blockhalterdelta = 0.4; // abstand der halterung innen/aussen, nur für loch hinzugefügt
blockhalterofs = 0.5; 
blockhalterbodenrundung = 1.2; // radius

battdmdelta = 0.3;
battdmAAA = 10.5 + battdmdelta;
battdmAA = 14.5 + battdmdelta + 0.1;
battdm18650 = 18.6 + battdmdelta;

// hier auswählen:
batterieAA();
// batterie18650();
 //batterieAAA();

// Tests
// testvisualisierung1(10); // zusammengebaute module, wert: abstand der blöcke
// testvisualisierung2(10); // zwei teile zum Verbindungstest

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
module testvisualisierung1(ofs) {
    translate([0,-ofs,0])
    batterieAA();
    translate([-blockbreite-ofs,-ofs,0])
    batterie18650();
    translate([blockbreite+ofs,-ofs,0])
    batterieAAA();

    translate([0,blockbreite+ofs,0]) {
        translate([0,-ofs,0])
        batterieAA();
        translate([-blockbreite-ofs,-ofs,0])
        batterie18650();
        translate([blockbreite+ofs,-ofs,0])
        batterieAAA();
    }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
module testvisualisierung2(dist) {
    difference() {
        union() {
            batterieAA();
            translate([-blockbreite-dist,0,0])
            batterieAA();
        }
        
        union() {
            translate([-100,5,-1])
            cube([200,100,100]);

            translate([-100,-105,-1])
            cube([200,100,100]);
            
            translate([-10,-10,-1])
            cube([200,100,100]);
            
            translate([-135,-10,-1])
            cube([100,100,100]);
        }
    }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
module batterieAA() {
    difference() {
        union() {
            block();
        }
        
        union() {
            abstand = 0.7;
            
            translate([battdmAA/2+abstand,battdmAA/2+abstand,blockboden])
            cylinder(d=battdmAA,h=blockhoehe);

            translate([-battdmAA/2-abstand,battdmAA/2+abstand,blockboden])
            cylinder(d=battdmAA,h=blockhoehe);

            translate([battdmAA/2+abstand,-battdmAA/2-abstand,blockboden])
            cylinder(d=battdmAA,h=blockhoehe);

            translate([-battdmAA/2-abstand,-battdmAA/2-abstand,blockboden])
            cylinder(d=battdmAA,h=blockhoehe);
        }
    }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
module batterieAAA() {
    difference() {
        union() {
            block();
        }
        
        union() {
            abstand = 3.6;
            
            translate([0,0,blockboden])
            cylinder(d=battdmAAA,h=blockhoehe);

            translate([battdmAAA/2+abstand,battdmAAA/2+abstand,blockboden])
            cylinder(d=battdmAAA,h=blockhoehe);

            translate([-battdmAAA/2-abstand,battdmAAA/2+abstand,blockboden])
            cylinder(d=battdmAAA,h=blockhoehe);

            translate([battdmAAA/2+abstand,-battdmAAA/2-abstand,blockboden])
            cylinder(d=battdmAAA,h=blockhoehe);

            translate([-battdmAAA/2-abstand,-battdmAAA/2-abstand,blockboden])
            cylinder(d=battdmAAA,h=blockhoehe);
        }
    }
}

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
module batterie18650() {
    difference() {
        union() {
            block();
        }
        
        union() {
            abstand = -2.1;

            // hingefummelte Positionen
            translate([-battdm18650/2-abstand+1.4,battdm18650/2+abstand+0.5,blockboden])
            cylinder(d=battdm18650,h=blockhoehe);

            translate([+battdm18650/2+abstand+0.5,-battdm18650/2-abstand+1.5,blockboden])
            cylinder(d=battdm18650,h=blockhoehe);
        }
    }
}


//*************************************************************************************
//*************************************************************************************
module block() { // der Basisblock: Aussenform und Befestigungselemente
    difference() {
        union() {
            translate([-blockbreite/2+blockrundung,-blockbreite/2,blockbodenrundung])
            cube([blockbreite-2.0*blockrundung,blockbreite,blockhoehe-blockbodenrundung]);
            translate([-blockbreite/2,-blockbreite/2+blockrundung,blockbodenrundung])
            cube([blockbreite,blockbreite-2.0*blockrundung,blockhoehe-blockbodenrundung]);
            
            translate([-blockbreite/2+blockrundung,-blockbreite/2+blockbodenrundung,0])
            cube([blockbreite-2.0*blockrundung,blockbreite-2*blockbodenrundung,blockbodenrundung]);
            translate([-blockbreite/2+blockbodenrundung,-blockbreite/2+blockrundung,0])
            cube([ blockbreite-2*blockbodenrundung,
                      blockbreite-2.0*blockrundung,blockbodenrundung]);

            color("cyan") {
                translate([-blockbreite/2+blockbodenrundung,+blockbreite/2-blockrundung,blockbodenrundung])
                rotate([90,0,0])
                cylinder(h=blockbreite-2*blockrundung, r=blockbodenrundung);

                translate([blockbreite/2-blockbodenrundung,+blockbreite/2-blockrundung,blockbodenrundung])
                rotate([90,0,0])
                cylinder(h=blockbreite-2*blockrundung, r=blockbodenrundung);
                
                translate([-blockbreite/2+blockrundung,+blockbreite/2-blockbodenrundung,blockbodenrundung])
                rotate([0,90,0])
                cylinder(h=blockbreite-2*blockrundung, r=blockbodenrundung);

                translate([-blockbreite/2+blockrundung,-blockbreite/2+blockbodenrundung,blockbodenrundung])
                rotate([0,90,0])
                cylinder(h=blockbreite-2*blockrundung, r=blockbodenrundung);
            }

            color("red") {
                translate([blockbreite/2.0-blockrundung,blockbreite/2.0-blockrundung,0])
                rounded_cylinder(hp=blockhoehe, rp=blockrundung, np=blockbodenrundung);
                translate([blockbreite/2.0-blockrundung,-blockbreite/2.0+blockrundung,0])
                rounded_cylinder(hp=blockhoehe, rp=blockrundung, np=blockbodenrundung);
                translate([-blockbreite/2.0+blockrundung,blockbreite/2.0-blockrundung,0])
                rounded_cylinder(hp=blockhoehe, rp=blockrundung, np=blockbodenrundung);
                translate([-blockbreite/2.0+blockrundung,-blockbreite/2.0+blockrundung,0])
                rounded_cylinder(hp=blockhoehe, rp=blockrundung, np=blockbodenrundung);
            }

            color("green") {
                translate([blockbreite/2.0-blockhalterofs+blockhalterrundung,0,0])
                rounded_cylinder(hp=blockhoehe, rp=blockhalterrundung, np=blockhalterbodenrundung);

                translate([0,blockbreite/2.0-blockhalterofs+blockhalterrundung,0])
                rounded_cylinder(hp=blockhoehe, rp=blockhalterrundung, np=blockhalterbodenrundung);
            }
        }
        
        union() {
            color("blue") {
                translate([-blockbreite/2.0-blockhalterofs+blockhalterrundung,0,-1])
                cylinder(h=blockhoehe+10.0, r=(blockhalterrundung+blockhalterdelta));

                translate([0,-blockbreite/2.0-blockhalterofs+blockhalterrundung,-1])
                cylinder(h=blockhoehe+10.0, r=(blockhalterrundung+blockhalterdelta));

                translate([-blockbreite/2.0-blockhalterofs+blockhalterrundung,0,-1])
                cylinder(h=1.5, r=(blockhalterrundung+blockhalterdelta+0.5));

                // Fase
                translate([0,-blockbreite/2.0-blockhalterofs+blockhalterrundung,-1])
                cylinder(h=1.5, r=(blockhalterrundung+blockhalterdelta+0.5));
            }
        }
    }
}

//*************************************************************************************
//*************************************************************************************
// https://www.thingiverse.com/groups/openscad/forums/general/topic:17201
// r[adius], h[eight], [rou]n[d]
module rounded_cylinder(rp,hp,np) {

    rotate_extrude(convexity=1) {
        offset(r=np) 
        offset(delta=-np) 
        square([rp,hp]);

        square([np,hp]);
    }

    translate([0,0,hp-np])
    cylinder(r=rp,h=np);
}




