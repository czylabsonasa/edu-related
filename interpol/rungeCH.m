clf; clear;
% Runge example - Chebysev points

fun=@(x) 1./(1+25*x.^2);
xx=linspace(-1,1);
yy=fun(xx);

nsp=0;
for np=[3,9,15]
   nsp=nsp+1;subplot(3,1,nsp);
   x=cos(pi*(2*(1:np)-1)/(2*np));
   pol=polyfit(x,fun(x),np-1);
   yyy=polyval(pol,xx);
   plot(xx,yy,xx,yyy);
   maxdiff=max(abs(yy-yyy));
   title(sprintf("num of Chebysev points: %d\nmax difference: %.2f\n",np,maxdiff));
end