// Angaben sind in mm

$fn = 200;

// Breite der Halterung, Höhe der Wände
breite = 40.1;
hoehe = 12;

// Boden und Wand links/rechts
bodendicke = 8;
wandstaerke = 5;

// Seitenwände links und rechts (grün)
Seitenwandstaerke = 2;
Seitenwandueberstand = 5;

// Breite der Bucht und Rundungsradius
abstand = 11;
rundung = 7;

// Tiefe der Minihaltegnubbel (Rot)
Gnubtiefe = 0.4;
Gnubabstand = 2.2+1.9;
Gnubhoehe = 1.9;
Gnubdurchmesser = 4.4;


// Bohrungsdurchmesser für LED und Fotodiode.
bohrungsd=5.0;
// hebt die Bohrung von der Bodenplatte ab
bohrungsdelta=0;
bohrungsverschiebung = 4;

// Für die LED, damit es nicht zu tief gesteckt werden kann, Bohrung etwas größer
ledtiefe = 8.0;
leddurchmesser = 5.3;
ledringdurchmesser = 10.0;

// Für die Drahstifte der LED/Fototransistor
umr10zinmm = 25.4/10;
ledfusshoehe = 5;
ledstiftdurchmesser = 1;
// 4 Löcher in Y-Richtung
ledabstand = 3*umr10zinmm;
// Löcher in X-Richtung ausgucken...
ledbreite = 11*umr10zinmm;
ledubrhang = 2;


// ==================================================
// Aufbau der Objekte
boden=[2*wandstaerke+abstand,breite,bodendicke];
// Wand steht links/rechts bündig zum Boden
wand=[wandstaerke,breite,hoehe];

// Tiefe berechnet sich aus Bodenbreite und 
// etwas Verschiebung
bohrungst=boden[0]+2*15;
bohrungy = breite/2+bohrungsverschiebung;
bohrungz = boden[2]+bohrungsd+bohrungsdelta;
bohrung=[-15,bohrungy,bohrungz];


//**************************************************************
// Zusammenbau der Teile
difference () {
    gehaeuse();

    ledfassung();
    
    // bodenplatte wg. durchstossenden Rundungen
    translate([-50,-50,-10])
    cube([100,100,10]);
}    

//**************************************************************
// linke und rechte Wand anfügen
module gehaeuse() {
    union() {
        // Basisplatte
        cube(boden);

        drahthalterung();
        
        translate([0,0,boden[2]]) 
        rrect(wand,rundung);
        translate([boden[0]-wand[0],0,boden[2]]) 
        rrect(wand,rundung);
        
        // Seitenwände
        color("green")
        translate([0,-Seitenwandstaerke,0])
        cube([2*wandstaerke+abstand,Seitenwandstaerke,bodendicke+Seitenwandueberstand]);
        
        color("green")
        translate([0,breite,0])
        cube([2*wandstaerke+abstand,Seitenwandstaerke,bodendicke+Seitenwandueberstand]);
        
        // 4 Haltegnubbel für die Lüfterlöcher        
        color("red")
        translate([wandstaerke,Gnubabstand,bodendicke+Gnubdurchmesser/2+Gnubhoehe])
        rotate ([0,90,0])
        cylinder(h=Gnubtiefe,d=Gnubdurchmesser);
        
        color("red")
        translate([wandstaerke,breite-Gnubabstand,bodendicke+Gnubdurchmesser/2+Gnubhoehe])
        rotate ([0,90,0])
        cylinder(h=Gnubtiefe,d=Gnubdurchmesser);
        
        color("red")
        translate([wandstaerke+abstand-Gnubtiefe,Gnubabstand,bodendicke+Gnubdurchmesser/2+Gnubhoehe])
        rotate ([0,90,0])
        cylinder(h=Gnubtiefe,d=Gnubdurchmesser);
        
        color("red")
        translate([wandstaerke+abstand-Gnubtiefe,breite-Gnubabstand,bodendicke+Gnubdurchmesser/2+Gnubhoehe])
        rotate ([0,90,0])
        cylinder(h=Gnubtiefe,d=Gnubdurchmesser);
        
        color("white")
        translate([-ledtiefe+wandstaerke,bohrungy,bohrungz])
        rotate ([0,90,0]) 
        cylinder (h = ledtiefe-wandstaerke,d=ledringdurchmesser);
        
        color("white")
        translate([2*wandstaerke+abstand,bohrungy,bohrungz])
        rotate ([0,90,0]) 
        cylinder (h = ledtiefe-wandstaerke,d=ledringdurchmesser);
    };
}

// *************************************************************************************
module ledfassung() {
    // LED ist irreführend, fototransistor und led haben identisches gehäuse
    color("blue")
    translate(bohrung) 
    rotate ([0,90,0]) 
    cylinder (h = bohrungst,d=bohrungsd, $fn=200 );
    
    color("white")
    translate([-ledtiefe+wandstaerke,bohrungy,bohrungz])
    rotate ([0,90,0]) 
    cylinder (h = ledtiefe-wandstaerke,d=leddurchmesser);
    
    color("white")
    translate([2*wandstaerke+abstand,bohrungy,bohrungz])
    rotate ([0,90,0]) 
    cylinder (h = ledtiefe-wandstaerke,d=leddurchmesser);
}

// *************************************************************************************
module drahthalterung() {
    mittey = breite/2;
    mittex = (2*wandstaerke+abstand)/2;
    
    difference () {
        // bodenplatte
        color("brown")
        translate([mittex-ledbreite/2-ledubrhang,mittey-ledabstand/2-ledubrhang,0])
        cube([ledbreite+2*ledubrhang,ledabstand+2*ledubrhang,ledfusshoehe]);
            
        color("brown")
        translate([mittex-ledbreite/2,mittey+ledabstand/2,-1])
        cylinder (h = ledfusshoehe+2,d=ledstiftdurchmesser);
        
        color("brown")
        translate([mittex-ledbreite/2,mittey-ledabstand/2,-1])
        cylinder (h = ledfusshoehe+2,d=ledstiftdurchmesser);
        
        color("brown")
        translate([mittex+ledbreite/2,mittey+ledabstand/2,-1])
        cylinder (h = ledfusshoehe+2,d=ledstiftdurchmesser);
        
        color("brown")
        translate([mittex+ledbreite/2,mittey-ledabstand/2,-1])
        cylinder (h = ledfusshoehe+2,d=ledstiftdurchmesser);
    }
}

//=================================================================
module rrect(size, radius)
{
    union() {
        cube([size[0],size[1],size[2]-radius]);
        
        translate([0,radius,size[2]-radius]) 
        cube([size[0],size[1]-2*radius,radius]);
        
        translate([0,radius,size[2]-radius]) 
        rotate ([0,90,0]) 
        cylinder(h=size[0],r=radius );
        
        translate([0,size[1]-radius,size[2]-radius]) 
        rotate ([0,90,0]) 
        cylinder(h=size[0],r=radius);
   }
}
