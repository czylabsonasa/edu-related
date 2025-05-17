% ea: 8.oldal példa (téglatest)
% mesh
clear;
clf;clc;

fun0=@(x,y) 2*x.*y + 2000./x + 2000./y;
fun=@(v) fun0(v(1),v(2));


[X,Y]=meshgrid(linspace(0,15,33),linspace(0,15,33));
Z=fun0(X,Y);
mesh(X,Y,Z);

%rng(222);
x0=15*rand(2,1);
[loc,val,status,info]=fminsearch(fun,x0);
loc
val
%info
