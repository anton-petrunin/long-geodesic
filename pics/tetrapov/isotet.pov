// http://xahlee.org/3d/index.html

// sample scene file for the mesh object 
// 3 triangles

#include "colors.inc"
#include "textures.inc"

//a texture for falling snow
#declare frac = 0.1;       //fraction of texture covered with White
#declare frac1= frac+0.001;
#declare falling_snow =
  texture {
    pigment {
      radial
      color_map {
        [ 0.00       color Clear ] [ 0.5-frac1   color Clear ]
        [ 0.5-frac   color White ] [ 0.5+frac    color White ]
        [ 0.5+frac1  color Clear ] [ 1.00        color Clear ]}
      turbulence 4  octaves 9  omega 8 }
      finish { Luminous }
}


#declare c1 =
texture{
    pigment{ rgbf<.93,.95,.98,0.825>*0.99}
    finish { ambient 0.0 diffuse 0.15
             reflection{0.1,0.1}
             specular 0.6 roughness 0.005
             conserve_energy
           } // end finish
  } // end of texture


background { color White}

#declare r=0.005;

#declare K=1.4;

#declare an=1;
#declare h=1.7*K;
#declare l=0.7*K;

#declare A=<h, l, 0>;
#declare B=<h, -l, 0>;
#declare C=<-h, l*cos(an), l*sin(an)>;
#declare D=<-h, -l*cos(an), -l*sin(an)>;

#declare an1=atan(l*sin(an)/(2*h));


#declare ABC=object{
	box{<0, -10, -10><-10, 10, 10>}  
	rotate<0, an1*180/3.14159265359-90, 0>
	translate<h, 0, 0>
	}


#declare ABD=object{
	box{<0, -10, -10><-10, 10, 10>}  
	rotate<0, 90-an1*180/3.14159265359, 0>
	translate<h, 0, 0>
	}

#declare ACD=object{
	object {ABC rotate <0, 0, 180>}
	rotate <an*180/3.14159265359, 0, 0>
	}

#declare BCD=object{
	object {ABD rotate <0, 0, 180>}
	rotate <an*180/3.14159265359, 0, 0>
	}

#declare K2=0.98;


union{
//	sphere {A, 4*r}
//	sphere {B, 4*r}
//	sphere {C, 4*r}
//	sphere {D, 4*r}
	cylinder{A, B, r}
	cylinder{A, C, r}
	cylinder{A, D, r}
	cylinder{B, C, r}
	cylinder{B, D, r}
	cylinder{C, D, r}
	no_shadow
	no_reflection
	scale K2
}


intersection{
		object {ABC}
		object {ABD}
		object {ACD}
		object {BCD}
//	texture{Glass}
	texture { falling_snow scale 2	}	
		interior{ior 1
		fade_distance 200 fade_power .05+.15 caustics 2
		}
	scale K2
	}


#declare x1=0.9*A+0.1*C;

#declare k2=0.6749999879019517;
#declare x2=k2*B+(1-k2)*C;

#declare k3=0.56666664983981407;
#declare x3=k3*B+(1-k3)*D;

#declare k4=0.42499997859576055;
#declare x4=k4*A+(1-k4)*D;

#declare k5= 0.23333330356274817;
#declare x5=k5*A+(1-k5)*C;

#declare k6= 0.17499996928956951;
#declare x6=k6*B+(1-k6)*C;

#declare k7= 0.29999999999999949;
#declare x7=k7*C+(1-k7)*D;

#declare k8= 0.074999965567092874;
#declare x8=k8*A+(1-k8)*D;

#declare k9=0.09999996505192188;
#declare x9=k9*B+(1-k9)*D;

#declare k10=0.32499997487328391 ;
#declare x10=k10*B+(1-k10)*C;

#declare k11=0.43333331132898756;
#declare x11=k11*A+(1-k11)*C;

#declare k12=0.57499998417947484;
#declare x12=k12*A+(1-k12)*D;

#declare k13=0.76666665760605346;
#declare x13=k13*B+(1-k13)*D;

#declare k14=0.82499999348566577;
#declare x14=k14*B+(1-k14)*C;

#declare k15=0.70000000000000018;
#declare x15=k15*A+(1-k15)*B;

#declare k16=0.92499999720814263;
#declare x16=k16*A+(1-k16)*D;

#declare K1=0.99;

#declare Geodesic=spline{
//	natural_spline
	0, x1,
	K1*0.1125, x2,
	K1*0.16667, x3,
	K1*0.2375, x4,
	K1*0.33333, x5,
	K1*0.3625, x6,
	K1*0.45, x7,
	K1*0.4875, x8,
	K1*0.5, x9,
	K1*0.6125, x10,
	K1*0.66667, x11,
	K1*0.7375, x12,
	K1*0.83333, x13,
	K1*0.8625, x14,
	K1*0.95, x15,
	K1*0.9875, x16,
	K1*1., x1,
	1, 0.1*x2+0.9*x1,
	}

// Parameters
// ==========
//
// Spline       Shape of rope - using the 0.0 to 1.0 region
// Radius       POV units
// Strands      Number of strands - integer not less than 3
// Twistyness   Arbitrary units per actual length
// Fatness      Arbitrary units - controls ratio of strand size to rope width
// U-Points     number of mesh2 points along the length - you'll need lots of this
// V-Points     number of mesh2 points around the cross section
// Filename   
#include "Rope.inc"
object {
	Rope(Geodesic, 0.04, 5, 3, 1.5, 200, 50, "ropedata2.dat")
	texture { uv_mapping
	pigment {gradient v-5*u	
	colour_map {
        [0   rgb <1,0.8,0.7>]
        [0.5 rgb <1,0.8,0.7>*0.5]
        [1   rgb <1,0.8,0.7>]
      }
      scale 0.003
    }
  }
//	no_shadow
	no_reflection
}




camera {
orthographic
 location <1, -5, 3>*1
 // location <0, 0.1, 3>*0.27
  look_at <0,0,0>
  sky   <0,-sin(an1),cos(an1)>
}

light_source {<1, -5, 4>*4 color White}
	
