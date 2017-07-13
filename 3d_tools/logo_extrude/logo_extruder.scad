$fs = 0.1;
$fn = 500;

//guidle of preperation can be found here
//incscape prep guide: https://cubehero.com/2013/11/11/how-to-generate-extruded-3d-model-from-images-in-openscad/

filename="/tmp/logo.dxf";  //filename of the extruded dxf
extrude_height = 3;   //hight of the extruded log in mm
base_hight = 4;        //hight of solid base in mm
width = 60;            //width of the logo (for scaling) in mm

mirror_stamp=true;   //shall it be mirrored true or false

module extrude_logo() {
  resize([width,0,0], auto=[true,true,false]) {
    union() {
      //resize([(width + 3) ,0,0] , auto=[true,true,false]) {
      //create the base
        translate ([0,0,-base_hight])  
      
          hull() 
            linear_extrude(height = base_hight, center = false, convexity = 0)
              import (file = filename);
  
      
        linear_extrude(height = extrude_height, center = false, convexity = 0)
          import (file = filename);
              
      }
    }
  
}



if ( mirror_stamp == true ) {
    mirror([1,0,0]) extrude_logo();
    }
else
    extrude_logo();