//
// Case that goes over a panel mount charger.  This is to provide a protective cover
// for the charger when it is in a motorcycle tank bag.
//

// The Belfry OpenScad Library, v2:  https://github.com/BelfrySCAD/BOSL2
// This library must be installed in your instance of OpenScad to use this model.
include <BOSL2/std.scad>
include <BOSL2/threading.scad>

// *** Model Parameters ***
/* [Model Parameters] */


// Height of the case large portion
case_base_height = 44;

// Thickness of the outside wall
case_wall_thickness = 3;

// Charger Threaded Hole Diameter
charger_diameter = 29.5;

// Thread pitch for the charger hole.
thread_pitch = 1.5;

// Overlap Tolerance for cutting objects when needed.
overlap = 0.1;

// *** "Private" variables ***
/* [Hidden] */

// Outside Diameter of the case
case_diameter = charger_diameter + case_wall_thickness;

// OpenSCAD System Settings
$fa = 1;
$fs = 0.4;

//
// Builds the case.
//
module charger_case() {
  // threaded_nut(shape="cylinder", nutwidth=16, id=8, h=8, pitch=1.25, $slop=0.1, $fa=1, $fs=1);

  difference() {
    cyl(h=case_base_height, d=case_diameter);


    threaded_rod(d=charger_diameter, height=case_base_height + 2, pitch=thread_pitch);
  }
}

charger_case();
