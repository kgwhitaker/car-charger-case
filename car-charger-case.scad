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
charger_diameter = 29;

// Thread pitch for the charger hole.
thread_pitch = 1.5;

// Overlap Tolerance for cutting objects when needed.
overlap = 0.1;

// Diameter for hole for the wire to exit the case
wire_exit_diameter = 8;

// Distance from the base of the charger to the exit point that it tapers too.
wire_enclosure_height = 20;

// *** "Private" variables ***
/* [Hidden] */

// Outside Diameter of the case
case_diameter = charger_diameter + case_wall_thickness;

// OpenSCAD System Settings
$fa = 1;
$fs = 0.4;

//
// Builds the base case.
//
module charger_case() {

  union() {

    diff()
      cyl(h=case_base_height, d=case_diameter) {

        tag("keep") position(TOP)
            cyl(
              l=wire_enclosure_height, d1=charger_diameter + case_wall_thickness,
              d2=wire_exit_diameter + 2 * case_wall_thickness, anchor=BOTTOM
            );

        tag("remove")
          threaded_rod(d=charger_diameter, height=case_base_height + 2, pitch=thread_pitch);
      }
  }
}


// 
// The wire exit area where connections are made and leaves the case.
//
module wire_exit() {
  translate([0, 0, (case_base_height / 2) - overlap])
    cyl(
      l=wire_enclosure_height + 2, d1=charger_diameter,
      d2=wire_exit_diameter, anchor=BOTTOM
    );
}

//
// Builds the entire model.
//
module build_model() {
  difference() {
    charger_case();

    wire_exit();
  }
}

// Build the model
build_model();
