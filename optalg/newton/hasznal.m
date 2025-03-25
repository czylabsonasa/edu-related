clf; clear;
hold on;

F=rosenbrock_2var();
fxy=F.f;
f=F.fV;
df=F.dfV;
H=F.d2fV;

% lásd előadás, 116 oldal
x0=[-1.2;1];


% rajz (kontúr)
[X,Y]=meshgrid(linspace(-1.5,2,55),linspace(-3.5,4,66));
Z=fxy(X,Y);
contour(X,Y,Z,33);

[h,s]=newton_sima(f,df,H,x0);
s
plot(x0(1),x0(2),"Or");
plot(h(1,:),h(2,:),"k*-");


