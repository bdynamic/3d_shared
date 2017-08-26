/*
	Item:	Parametric Filament Swatch	
	
	Description:  A printable sample of filament color for a given filament type.

    Author:         Ezra Reynolds 
                    Ezra_Reynolds@signalcenters.org

    Notes:	Shape/Concept based on 	http://www.thingiverse.com/thing:664377
			This design is parametric, original is static.
	
	Printing:
		Printer: 	Makergear M2
		Options: 	20% Infill
		Time:	 	13 minutes
		Filament:	6.44g
		Cost:		$0.30

    Version History:
		2015-05-18 - v1.0 - First Functional Version

*/


// ======================= INCLUDE FILES ==========================
include <MCAD/2Dshapes.scad>;

// ======================= PARAMETERS =============================
mm			= 25.4;		// Inch to mm conversion
$fn 		= 50;		// Circle smoothness

// Define the range of thicknesses [minThick:stepSize:maxThick]
//  (e.g. for min=0.5, step=0.5, max=3], we would have 0.5, 1, 1.5, 2, 2.5, 3
minThick = 0.4;		// Minimum sample thickness
stepSize = 0.4;		// Delta of each thickness 
maxThick = 4;		// Maximum sample thickness

// Swatch Geometry
width			= 15;	// Width of the sample, e.g 1 inch
corner			= 3;		// Corner Radius
rimThickness 	= 4;		// Lip thickbess
tagLength 		= 20 ;	// Length of a "tag" on the top, for writing vendor/color
sampleLength 	= 8;	// Length of each sample thickness

// Mounting hole, separation groove
hole_d			= 4.2;	// Hole for mounting
holePosition 	= [hole_d/2+rimThickness+ 1, width/2, 0];	// [X,Y,Z] position of hole
grooveDepth 	= 1;	// Depth of the groove separating tag+sample

// Derived Parameters
steps 	= (maxThick-minThick) / stepSize;	// How many steps
echo ("Steps=", steps);
totalLength = tagLength + (steps+1)*sampleLength;	// Total length of swatch


// ======================= CREATE 3D PART==========================

difference()
{
	union()
	{
		intersection()
		{
			union()
			{
				// Create steps of thickness
				for (i = [0:steps])
				{
					
					length = tagLength + (steps+1-i)*sampleLength;
					echo ("i=", i, "Thickness=", (i+1)*stepSize, "Length=", length);
				
					// Make the steps
					translate ([0, 0, i*stepSize]) 
						cube ([length, width, stepSize]);
						
				}
			} // End Union
			
			// Round the corners
			translate ([totalLength/2, width/2, -1]) 
				linear_extrude(100, convexity=20)
					roundedSquare ([totalLength, width], corner);
		
		}	// End intersection
		
		// Add Rim
		translate ([totalLength/2, width/2, 0]) 
			linear_extrude((steps+1)*stepSize, convexity=20)
				difference()
				{
					roundedSquare ([totalLength+rimThickness*2, width+rimThickness*2], corner);
					roundedSquare ([totalLength, width], corner);
				}

	} // End Union

	// Make Hole
	translate (holePosition) 
		cylinder (d=hole_d, h=4*(steps+2)*stepSize, center=true);

	// Make groove for tag separation
	translate ([tagLength, width/2, (steps+1)*stepSize]) 
		rotate ([90, 0, 0]) 
			cylinder (r=grooveDepth, h=width*2, center=true);

} // End difference

// END OF FILE.  S.D.G.