// PRUSA iteration3
// Y frame corners
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

//possible damper source http://www.ebay.de/itm/Schwingungsdampfer-Typ-A-M4-15-H-15-Metallpuffer-Anti-Vibration-Mount-/251255482807?hash=item3a7ffe69b7:g:xAgAAOSwA29Y4~gw

$fs = 0.1;
$fn = 500;

element_width=21;
damper_dia=15;
support_hight=4;
base_clearance=2; 
drill_dia=4.1;


mirrored=false;


module corner_base(){	
 translate([-9,-11,0])cube([element_width,22,49]);  //18 org
 
}

module corner_holes(){
 translate([-11,-11,0]){
  // Bottom hole
  translate([0,11,10]) rotate([0,90,0]) translate([0,0,-5]) cylinder(h = 270, r=4.4, $fn=30);
  // Top hole
  translate([0,11,30]) rotate([0,90,0]) translate([0,0,-5]) cylinder(h = 270, r=4.4, $fn=30);
  // Middle hole
  //translate([11,0,20]) rotate([0,0,90]) rotate([0,90,0]) translate([0,0,-5]) cylinder(h = 270, r=5.4, $fn=30);
  // Bottom hole bridge
  translate([0,8.8,10]) rotate([0,90,0]) translate([0,0,-5]) cylinder(h = 270, r=2.6, $fn=6);
  // Top hole bridge
  translate([0,8.8,30]) rotate([0,90,0]) translate([0,0,-5]) cylinder(h = 270, r=2.6, $fn=6);

  // Washer hole
  //translate([11,-3,20]) rotate([0,0,90]) rotate([0,90,0]) translate([0,0,-5]) cylinder(h = 10, r=11, $fn=30);

  // Top smooth rod insert
  // Smooth rod place
  //translate([11,2.75,47]) rotate([0,90,90]) cylinder(h = 10, r=4.2, $fn=30); 
  // Ziptie
  //translate([-5,6,41])  cube([30,3.5,2]);
  
  // LM8UU keepout
  //difference(){
   // translate([11,12.5,46]) rotate([0,90,90]) cylinder(h = 270, r=8, $fn=30);
    //translate([21,12.5,62]) rotate([0,90,90]) cube([20,20,30]);
  //} 
  
  translate([21,12.5,57]) rotate([0,90,90]) cube([15.2,20,20]);
 
 }
 
}

module corner_fancy(){
 // Side corner cutouts
  translate([-8,-9,0]) rotate([0,0,-45-180]) translate([-15,0,-1]) cube([30,30,51]);
  translate([11,-9,0]) rotate([0,0,45-180]) translate([-15,0,-1]) cube([30,30,51]);
 // Top corner cutouts
    translate([7,0,44]) rotate([0,45,0]) translate([-15,-15,0]) cube([30,30,30]);
    translate([-7,0,41]) rotate([0,-45,0]) translate([-15,-15,0]) cube([30,30,30]);
    rotate([0,0,90]){
    translate([-9.5,0,40]) rotate([0,-45,0]) translate([-15,-15,0]) cube([30,30,30]);
    }
}

module selective_infill(){
    
    translate([7,2,0.8])cube([0.2,33,5]); 
    translate([-7,2,0.8])cube([0.2,33,5]);
    
    translate([ 7,16,5.8])cube([0.2,8,11]);
    translate([-7,16,5.8])cube([0.2,8,11]);
    
    translate([7,2,16.8])cube([0.2,33,2]); 
    translate([-7,2,16.8])cube([0.2,33,2]);
}
    
    
// Final part
module corner(){
 // Rmirroredotate the part for better printing
    translate([0,0,11]) rotate([-90,0,0]) 
    {
    difference(){
        corner_base();
        corner_holes();
        corner_fancy();
        //translate([0,11,0]) rotate([90,0,0])selective_infill();
      
      //cut of the top holder for the rods
      translate([0,0,49]) cube([element_width+3,22,15], center = true);
      
      
      corner_fancy();
      
        
    }
    
    }

}



module damper_holder(){
    union() {
      cube([(damper_dia+4),(damper_dia+4),support_hight],center=false);  //base cube
      
      //support cube top
      translate([-2,0,(support_hight/2)]) rotate([0,90,0]) {
        difference() {
          cube([(damper_dia+2),(damper_dia+4),(support_hight/2)],center=false);
          translate([18,0,0]) rotate([0,0,40]) cube([(damper_dia+15),(damper_dia+15),(support_hight/2)],center=false);
        } 
      }
      
      //support cube bottom
      translate([0,0,(support_hight/2)]) rotate([0,-90,0]) {
        difference() {
          cube([(damper_dia+2),(damper_dia+4),(support_hight/2)],center=false);
          translate([18,0,0]) rotate([0,0,40]) cube([(damper_dia+15),(damper_dia+15),(support_hight/2)],center=false);
        }
      }
    }

}

module base_clear_remove() {
  cube([50,50,(base_clearance*2)], center=true);
}



module damper(){
  //this is for a damper of type A Gummipuffer M4
  union() {
    translate([0,0,23]) cylinder(8, d=4);  //rod top
    translate([0,0,8]) cylinder(15, d=damper_dia);
    cylinder(8, d=4);  //rod bottom
    
    translate([0,0,27.5]) cylinder(3.3, d=7); //mutter
    
  }
}


//translate([0,0,-10]) damper();  //only for debugging

module corner_with_damper(){

  //the damper holder
  difference() {
    translate([-9.5,-9.5,(15.0-base_clearance)]) {
        damper_holder();
      }
    translate([0,0,-base_clearance]) base_clear_remove();
    cylinder(60,d=drill_dia);
  }

  // the original cuttet corner
  translate([-2.5,-9,0]) rotate([90,0,0]) corner();
}

if ( mirrored == true ) {
    mirror([1,0,0]) corner_with_damper();
    }
else
    corner_with_damper();



