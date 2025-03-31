clf; clear;
% Runge examples

fun=@(x) 1./(1+25*x.^2);
xx=linspace(-1,1);
yy=fun(xx);

nsp=0
for np=[3,9,15]
   nsp=nsp+1;subplot(3,1,nsp);
   x=linspace(-1,1,np);
   pol=polyfit(x,fun(x),np-1);
   yyy=polyval(pol,xx);
   plot(xx,yy,xx,yyy);
   maxdiff=max(abs(yy-yyy));
   title(sprintf("num of points: %d\nmax difference: %.2f\n",np,maxdiff));
end