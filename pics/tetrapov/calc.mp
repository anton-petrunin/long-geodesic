input macros

verbatimtex
%&latex
\documentclass{article}
\begin{document}
etex


filenametemplate "%j-%1c.mps";
prologues:=3;


beginfig(1)
u:=1cm;
save a,b,c;

a/u=3.400000++1.078212++0.589030;
b/u=3.400000++0.321788++0.589030;
c/u=1.4;

z.a=origin;
z.b=(c, 0);
z.c=cross.top(circle(z.a, b), circle(z.b, a));
z.d=z.b+z.c-z.a;
draw z.a--z.b--z.c--z.a;

save v; pair v[];
v1=z.b;
v2=z.c;


for i=0 upto 6:
	draw v1*i--(v1*i+v2*3);
endfor;

for j=0 upto 3:
	draw v2*j--(v1*6+v2*j);
endfor;

z1=0.1[z.a, z.c];
z17=z1+6v1+2v2;

z2=crosspoint(z1,z17)(z.c,z.b);
show 1-abs(z2-z.b)/a;

z3=crosspoint(z1,z17)(z.b, z.d);
show 1-abs(z3-z.b)/b;

z4=crosspoint(z1,z17)(z.a+2*v1, z.d);
show 1-abs(z4-(z.a+2v1))/a;

z5=crosspoint(z1,z17)(z.a+2*v1, z.c+2v1);
show 1-abs(z5-(z.a+2*v1))/b;

z6=crosspoint(z1,z17)(z.c+2*v1, z.b+2v1);
show 1-abs(z6-(z.b+2*v1))/a;

z7=crosspoint(z1,z17)(z.c+2*v1, z.d+2v1);
show 1-abs(z7-(z.c+2*v1))/c;   

z8=crosspoint(z1,z17)(z.a+2*v1+2v2, z.d+2v1);
show 1-abs(z8-(z.a+2*v1+2v2))/a;   

z9=crosspoint(z1,z17)(z.b+2*v1+2v2, z.d+2v1);
show 1-abs(z9-(z.b+2*v1+2v2))/b;   

z10=crosspoint(z1,z17)(z.b+2*v1+2v2, z.c+4v1);
show 1-abs(z10-(z.b+2*v1+2v2))/a;   

z11=crosspoint(z1,z17)(z.a+4*v1+2v2, z.c+4v1);
show 1-abs(z11-(z.a+4*v1+2v2))/b;   

z12=crosspoint(z1,z17)(z.a+4*v1+2v2, z.d+4v1);
show 1-abs(z12-(z.a+4*v1+2v2))/a;   

z13=crosspoint(z1,z17)(z.b+4*v1+2v2, z.d+4v1);
show 1-abs(z13-(z.b+4*v1+2v2))/b;   

z14=crosspoint(z1,z17)(z.b+4*v1+2v2, z.c+6v1);
show 1-abs(z14-(z.b+4*v1+2v2))/a;

z15=crosspoint(z1,z17)(z.a+6*v1+2v2, z.b+4*v1+2v2);
show 1-abs(z15-(z.a+6*v1+2v2))/c;

z16=crosspoint(z1,z17)(z.a+6*v1+2v2, z.d+4v1+2v2);
show 1-abs(z16-(z.a+6*v1+2v2))/a;

show "we are here";
show abs(z2-z1)/abs(z1-z17);
show abs(z3-z1)/abs(z1-z17);
show abs(z4-z1)/abs(z1-z17);
show abs(z5-z1)/abs(z1-z17);
show abs(z6-z1)/abs(z1-z17);
show abs(z7-z1)/abs(z1-z17);
show abs(z8-z1)/abs(z1-z17);
show abs(z9-z1)/abs(z1-z17);
show abs(z10-z1)/abs(z1-z17);
show abs(z11-z1)/abs(z1-z17);
show abs(z12-z1)/abs(z1-z17);
show abs(z13-z1)/abs(z1-z17);
show abs(z14-z1)/abs(z1-z17);
show abs(z15-z1)/abs(z1-z17);
show abs(z16-z1)/abs(z1-z17);



draw z1--z17;



endfig;
end
