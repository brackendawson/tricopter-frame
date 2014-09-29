screw_points=[[43.5,6],[56.5,6],[43.5,36],[56.5,36],
              [22.5,68],[77.5,68],[6,85],[94,85],
              [35,115],[65,115]];
screw_m3_rad=2;
screw_m3_head_rad=3;
nut_m3_dia=5.5;

nuts=0;
$fn=30;

difference()
{
  /* minkowski of frame perimiter shrunk by 10mm in x and y and
   centered with a 5mm radius sphere. */
  minkowski()
  {
    linear_extrude(height=1) import("Tricopter_outer_-5mm.dxf");
    sphere(r=5);
  }
  // flat bottom
  translate([-10,-10,-10]) cube([120,150,10]);
  // holes
  for(point=screw_points)
  {
    translate([point[0],point[1],-1]) cylinder(r=screw_m3_rad, h=10);
    if(nuts==1)
    {
      translate([point[0],point[1],2]) nut(nut_m3_dia, 10);
    } else {
      translate([point[0],point[1],2]) cylinder(r=screw_m3_head_rad, h=10);
    }
  }
}

////for comparison
//translate([0,0,-1]) import("Tricopter.dxf");

module nut(d,h,horizontal=true)
{
  cornerdiameter =  (d / 2) / cos (180 / 6);
  cylinder(h = h, r = cornerdiameter, $fn = 6);
  if(horizontal)
  {
    for(i = [1:6])
    {
      rotate([0,0,60*i]) translate([-cornerdiameter-0.2,0,0]) rotate([0,0,-45]) cube([2,2,h]);
    }
  }
}