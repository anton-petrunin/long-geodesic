// Persistence of Vision Ray Tracer Include File
// File: Rope2.inc
// For POV Version: 3.6
// Desc: Macro sweeping a rope along a spline
// Date: 28-Feb-2005
// Auth: Mike Williams


// Requires makemesh.inc by Ingo Janssen <http://members.home.nl/seedseven/>
//
// Parameters
// Track        A spline that specifies the path along the object
//              The section of the spline between control points 0 and 1 will be used 
// Width        Thickness of the rope - actual POV-units
// Strands      Number of strands - should be an integer not less than 3
// Twist        Twistiness of the rope - arbitrary units per actual length
// U            The number of vertices along the path
// V            The number of vertices around the circumpherence
// FileName     The name of the file to whitch the mesh will be written. If is an
//              empty string (""), no file will be written. If a file name is given,
//              the macro will first check if it already exists. If that is so, it
//              will expect a mesh2 with the name "Surface" and try to parse the
//              existing file.

// This doesn't quite work for all possible splines.
// If things go horribly wrong, then use "Rope.inc" instead
  
#include "makemesh.inc"

#macro FindPoint(sv)
    (Shape(sv).x)*cos(A)*DRX + (Shape(sv).y)*sin(A)*DRX
  + (Shape(sv).y)*cos(A)*DRY - (Shape(sv).x)*sin(A)*DRY;
#end


#macro Rope(Track,Width,Strands,Twist,Fatness,U,V, Filename)
#if(strlen(Filename)>0)
  #if(file_exists(Filename))
    #debug concat("\n Parsing mesh2 from file: ", Filename, "\n")
    #local Build=0;
    #include Filename
     object{Surface}
  #else
    #local Build=1;
  #end
#else
  #local Build=1;
#end

#if (Build)
#local Verts = array[U*(V+1)]
#local Norms = array[U*(V+1)]
#local UV    = array[U*(V+1)]

#local S=2*Strands-2;
#local M=5*Fatness/Strands;
#local W=Width/(1+M);

#local Shape =
   spline {
     natural_spline
     #local K=-0.1;
     #while (K<=1.1)
        K, <sin(2*pi*K)-sin(S*pi*K)*M,cos(2*pi*K)+cos(S*pi*K)*M,0>,
        #local K=K+0.05;
     #end
   }
                           
// Calculate the Vertexes, Normals and UV arrays
#local DRY = y; // Arbitrary initial vector that X will be perpendicular to
#local uu=0;
#while (uu<U)
  #local vv=0;
  #if (uu = 0) 
    #local Distance = 0;
  #else
    #local Distance = Distance + vlength(Track(uu/U) - Track((uu-1)/U));
  #end
  #while (vv<=V)
     // UV information
     #local su = uu/U;
     #local sv = vv/V;
     #local UV[uu*(V+1)+vv] = <su,sv>;
     
     // Spline point and radius 
     #local P = Track(su);
     #local W=Width/(1+M);

     // Direction the spline is pointing
     #local DR = Track(su+0.001)-Track(su-0.001); 
     
     // Twist Angle
     #local A = 2*pi*Twist*Distance;

     // Vertex position
     // To prevent flipping, calculate from the previous DRY vector 
     #local DRX = W*vnormalize(vcross(DR,DRY));
     #local DRY = W*vnormalize(vcross(DRX,DR));
     #local Verts[uu*(V+1)+vv] = P + (Shape(sv).x)*cos(A)*DRX + (Shape(sv).y)*sin(A)*DRX
       + (Shape(sv).y)*cos(A)*DRY - (Shape(sv).x)*sin(A)*DRY;

     // Normal
     #local NP1 = FindPoint(sv);
     #local NP2 = FindPoint(sv+0.001);
     #local DS = NP2-NP1;
     #if (vlength(DS) = 0) // can happen at end point of Shape
       #local NP1 = FindPoint(sv-0.001); 
       #local NP2 = FindPoint(sv+0.001);
       #local DS = NP2-NP1;
     #end     

     #local Norms[uu*(V+1)+vv] = vcross(DR,DS);

     #local vv=vv+1;
  #end
  #local uu=uu+1;
#end

BuildWriteMesh2(Verts, Norms, UV, V, U-1, Filename)

#end
#end