% a 4. feladat generalt adattal
% techikailag kulcs az összefésülés

%clear; 
clf;close all;clf;

n=100;

xx=linspace(0,2*pi,n)';
%y=sin(xx)+sin(2*xx);
fun = @(x) sin(x) + x.*sin(2*x);
yy=fun(xx);


perc=50; % ez százalék
megvan=rand(n,1)<perc/100; 
hianyzik=~megvan;

nv=sum(megvan);
nh=sum(hianyzik);
assert(nv+nh==n);


tv=t(megvan);
yv=y(megvan);
th=t(hianyzik);

subplot(3,1,1);
plot(tv,yv,'k*',xx,yy,'b')
xlim([0,2*pi]);
title("megvan");

S=eye(n);
Sv=S(:,megvan); % S megvan
Sh=S(:,hianyzik); % S hianyzik

% elsorendu
D1=diag(ones(n,1))+diag(-1*ones(n-1,1),1);

% masodrendu
D2=-2*diag(ones(n,1))+diag(ones(n-1,1),1)+diag(ones(n-1,1),-1);

D = D1;
% olyan yh vektort keresunk mely a meglevo vektorral osszefesulve a leheto
% legsimabb: simasag elso/masodik differencia (derivalt) a leheto legkisebb
% az osszefesult vektor:
% y=Sh*yh+Sv*yv ->
% D*Sh*yh+D*Sv*yv a leheto legkisebb
% D*Sh*yh a leheto legkozelebb van a (-D*Sv*yv) vektorhoz...-> lkn
A=D*Sh;
b=D*Sv*yv;
yh=(A'*A)\(-A'*b);

subplot(3,1,2);
plot(th,yh,'r*',xx,yy,'b')
xlim([0,2*pi]);
title("hiányzók");


subplot(3,1,3);
plot(tv,yv,'k*',th,yh,'r*',xx,yy,'b')
xlim([0,2*pi]);

hiba = norm(yh - fun(th));

title(sprintf("összefésülve\nhiba: %.4f", hiba));
