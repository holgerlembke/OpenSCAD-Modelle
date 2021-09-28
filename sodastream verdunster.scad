/*
  Sodastream-Easy Verdunstungshilfe
  
  Verhindert Wasseransammlungen unter dem Plastikgehäuse

*/
$fn = $preview ? 20 : 100;


breite = 55;
stegbreite = 10;
steghoehe = 10;
nuttiefe = 3;

difference() {
    union() {
        translate([-breite-stegbreite,45,0])
        cube([breite*2+20,stegbreite,steghoehe]);

        translate([-breite-stegbreite,-45-10,0])
        cube([breite*2+20,stegbreite,steghoehe]);

        translate([-stegbreite/2,-45-5,00])
        cube([stegbreite,100,steghoehe]);
    }
    
    union() {
        translate([-breite-stegbreite/2,-45-15,steghoehe-nuttiefe])
        cube([stegbreite,120,steghoehe]);

        translate([breite-stegbreite/2,-45-15,steghoehe-nuttiefe])
        cube([stegbreite,120,steghoehe]);
    }
}
