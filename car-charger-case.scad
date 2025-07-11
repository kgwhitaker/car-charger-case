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
charger_diameter = 30;

// Thread pitch for the charger hole.
thread_pitch = 1.5;

// Diameter for hole for the wire to exit the case
wire_exit_diameter = 8;

// Distance from the base of the charger to the exit point that it tapers too.
wire_enclosure_height = 20;

// Wire feed tube height.
wire_feed_tube = 20;

// *** "Private" variables ***
/* [Hidden] */

// Outside Diameter of the case
case_diameter = charger_diameter + case_wall_thickness;

// OpenSCAD System Settings
$fa = 1;
$fs = 0.4;

// Overlap Tolerance for cutting objects when needed.
overlap = 0.1;

//
// Builds the round base case.
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
module wire_exit(z_offset) {
  translate([0, 0, z_offset])
    cyl(
      l=wire_enclosure_height + 2, d1=charger_diameter,
      d2=wire_exit_diameter, anchor=BOTTOM
    );
}

//
// Feed tube that runs up to the wire enclosure.
//
module feed_tube(z_offset) {
  difference() {
    translate([0, 0, z_offset])
      tube(h=wire_feed_tube, ir=5, wall=2);

    // This creates cutouts for the zip tie for wire strain relief
    translate([0, 0, z_offset + 4])
      rotate(-45)
        cuboid(size=[20, 4, 4]);

    translate([0, 0, z_offset + 4])
      rotate(45)
        cuboid(size=[20, 4, 4]);

    s_cut = 16;
    translate([0, s_cut / 2, z_offset + 8])
      cuboid(size=[s_cut, s_cut, s_cut]);
  }
}

//
// Builds the entire model.
//
module build_model() {
  feed_tube(case_base_height / 2 + wire_enclosure_height + wire_feed_tube / 2);

  difference() {
    charger_case();

    wire_exit(z_offset=( (case_base_height / 2) - overlap));
  }
}

// Build the model
build_model();
