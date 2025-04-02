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


subplot(3,1,1);hold on;
contour(X,Y,Z,33);
[h,sima]=newton_sima(f,df,H,x0);
sima
plot(x0(1),x0(2),"Or");
plot(h(1,:),h(2,:),"k*-");
title("sima newton");

subplot(3,1,2);hold on;
contour(X,Y,Z,33);
[h,dfp]=newton_dfp(f,df,x0);
dfp
plot(x0(1),x0(2),"Or");
plot(h(1,:),h(2,:),"k*-");
title("newton dfp");

subplot(3,1,3);hold on;
contour(X,Y,Z,33);
[h,bfgs]=newton_bfgs(f,df,x0);
bfgs
plot(x0(1),x0(2),"Or");
plot(h(1,:),h(2,:),"k*-");
title("newton bfgs");

