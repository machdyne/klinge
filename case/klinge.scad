/*
 * Klinge Enclosure
 * Copyright (c) 2025 Lone Dynamics Corporation. All rights reserved.
 *
 * required hardware:
 *  - 4 x M3 x 6mm bolts
 *  - 4 x M3 nuts
 *
 */

$fn = 36;

translate([0,0,0]) klinge();

//color([0.3,0.3,0]) translate([0,20,0]) klinge_stand();
//color([0.3,0.3,0]) translate([0,105,0]) klinge_stand();

module klinge_stand() {
    
    difference() {
        minkowski() {
            translate([10,0,0]) cube([40,30,52], center=true);
            sphere(0.5);
        }
        translate([10,0,0]) cube([23,100,42.5], center=true);
        rotate([90,0,0]) translate([0,0,-50]) cylinder(d=15, h=100);
    }
}

module klinge() {
    
    difference() {
        union() {
            
            // sidewalls
            translate([-0.25,63,0]) cube([3.5,128,42], center=true);
            translate([20,63,0]) cube([2,128,42], center=true);          
            
            // front panel
            translate([10,0,19.75]) cube([20,2,2.5], center=true);
            translate([10,0,0]) cube([20,2,3.5], center=true);            
            translate([10,0,-19.75]) cube([20,2,2.5], center=true);

            translate([3.25,0,0]) cube([3.5,2,42], center=true); 

            // back panel
            translate([10,125.75,16]) cube([20,2.5,10], center=true); 
            translate([10,125.75,-16]) cube([20,2.5,10], center=true); 
    
            // mount pads
            rotate([0,90,0]) translate([16,25+1,1]) cylinder(d=8, h=5, center=true);
            rotate([0,90,0]) translate([-16,25+1,1]) cylinder(d=8, h=5, center=true);
            rotate([0,90,0]) translate([16,(25+90)+1,1]) cylinder(d=8, h=5, center=true);
            rotate([0,90,0]) translate([-16,(25+90)+1,1]) cylinder(d=8, h=5, center=true);
                        
        }
        
        // guide rail
        translate([-1,65,0]) cube([2,130,6], center=true);

        // jtag cutout
        translate([30,100.7+1,-18.5]) cube([23,12.5,10], center=true);

        // bolt holes
        rotate([0,90,0]) translate([16,25+1,0]) cylinder(d=3.5, h=500, center=true);
        rotate([0,90,0]) translate([-16,25+1,0]) cylinder(d=3.5, h=500, center=true);
        rotate([0,90,0]) translate([16,(25+90)+1,0]) cylinder(d=3.5, h=500, center=true);
        rotate([0,90,0]) translate([-16,(25+90)+1,0]) cylinder(d=3.5, h=500, center=true);
 
        // nut holes
        rotate([0,90,0]) translate([16,25+1,-1]) cylinder(d=7, h=4, $fn=6, center=true);
        rotate([0,90,0]) translate([-16,25+1,-1]) cylinder(d=7, h=4, $fn=6, center=true);
        rotate([0,90,0]) translate([16,(25+90)+1,-1]) cylinder(d=7, h=4, $fn=6, center=true);
        rotate([0,90,0]) translate([-16,(25+90)+1,-1]) cylinder(d=7, h=4, $fn=6, center=true);

        // tool holes
        rotate([0,90,0]) translate([16,25+1,30]) cylinder(d=7, h=50, center=true);
        rotate([0,90,0]) translate([-16,25+1,30]) cylinder(d=7, h=50, center=true);
        rotate([0,90,0]) translate([16,(25+90)+1,30]) cylinder(d=7, h=50, center=true);
        rotate([0,90,0]) translate([-16,(25+90)+1,30]) cylinder(d=7, h=50, center=true);

        
    }
}
