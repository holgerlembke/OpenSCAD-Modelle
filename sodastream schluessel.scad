/*
  Sodastream-Easy Schraubenschlüssel
  um Anziehen der (!) Verbindungsmutter.
  
  Ein simpler 12 mm Schlüssel.
  
  Theoretisch könnten ich einen Schlüssel aus dem Werkzeugkasten
  nutzen. Andererseits kann dieser Schlüssel als Dauerwerkzeug am
  Gerät verbleiben. So viel praktischer.
*/
$fn = $preview ? 20 : 100;

aussendm = 20.0;
dicke = 8.0;
sw = 12.2;
stielbreite = 8.0;

difference() {
    union() {
        cylinder(d=aussendm,h=dicke);
        
        color(["blue"])
        translate([7,-stielbreite/2.0,0])
        cube([30,stielbreite,dicke]);
        
        translate([7+30,0,0])
        cylinder(d=stielbreite,h=dicke);
        
        translate([0,-7.0,0])
        cube([14,14,dicke]);
    }
    
    union(){
        color("purple") 
        translate([0,0,-1.0])
        linear_extrude(dicke+2.0) 
        circle(sw/2.0/cos(180/6), $fn=6);

        color("red")
        translate([-33.5,-15,-1])
        cube([30,30,dicke+2.0]);

        // Öse
        translate([7+30,0,-1])
        cylinder(d=3.5,h=dicke+2.0);

        // Rundung
        translate([14,14,-1.0])
        cylinder(d=20,h=dicke+2);
        translate([14,-14,-1.0])
        cylinder(d=20,h=dicke+2);
    }
}
