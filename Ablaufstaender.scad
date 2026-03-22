/*
    Ablaufständer
   
*/

$fn = $preview ? 20 : 200;


di = 35.0;
da = 45.0;
ho = 5;
hb = 30;

staender(da,di);
translate([75,0,0])
  staender(da+10,di+10);

module staender(da, di) {
  intersection() {
    union() {
      difference() {
        cylinder(d=da,h=ho);
        cylinder(d=di,h=ho);
      }

      for (i=[0:2]) {
        rotate([0,0,i*120])
          translate([di/2,-2.5,3])
            rotate([0,10,0])
              cube([5,5,hb]);
      }
    }
    translate([-100,-100,0])
      cube([200,200,hb-1]);
  }
}

