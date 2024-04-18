/*
    
    PCB-Halter
    
    notwendige Zutaten:
    - Schraube M3 x 30
    - Scheibe mit großem Außendurchmesser (DIN 9021) M3 (3,2 x 9,0 x 3)
    - Mutter M3
    - Feder 0,5 mm x 35 mm x 8 mm 
    
    Drucken mit hoher Füllung, damit sie "was wiegen tun".
    
    Bei der Feder muss man sehen, was der Markt hergibt. Ich habe
    zwei Federn ineinander gesteckt, um die nötige Kraft zu erhalten.
  
    Für ein einfaches, dünnes Stück Stahlblech A4 habe ich keine Quelle 
    gefunden. Oft sind die Bleche zu dick. Oder mit der (Schlag-) Schere
    geschnitten, daher scharfkantig und verzogen.
    
*/
$fn = $preview ? 20 : 200;

federda = 8.3;
federl = 20.0;

schraubenda = 3.2+0.8;
schraubenkda = 5.9+0.4;
schraubenkh = 2.5+0.2;

da = 20.0;
bottoml = 60.0;

magnetdm = 15.0+0.1;       // Null für ohne Magnet
magneth = 3.6+0.1;

kscheibendm = 8.8+0.2;

lochda = max(kscheibendm,federda)+0.2;

// besser getrennt exportieren, zwei Teile in Slicer importieren
// dort vervielfachen und anordnen lassen
/**/
translate([0,0,6]) top();
/**/
translate([20,20,bottoml]) bottom();
/**/


//================================================================
module bottom() {
    rotate([180,0,0])
    difference() {
        union() {
            cylinder(d=da,h=bottoml);
        }
        union() {
            cylinder(d=lochda,h=bottoml-5);
            cylinder(d=schraubenda,h=bottoml+5);
            cylinder(d=magnetdm,h=magneth);
        }
    }
}

//================================================================
module top() {
    rotate([180,0,0])
    difference() {
        union() {
            cylinder(d1=8,d2=da,h=3);
            cylinder(d2=12,d1=da,h=3);
            translate([0,0,3]) cylinder(d=da,h=3);
        }
        union() {
            cylinder(d=schraubenda,h=10);
            cylinder(d=schraubenkda,h=schraubenkh);
        }
    }
}

