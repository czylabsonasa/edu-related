clf; clear;
% Runge example - piecewise linear

fun=@(x) 1./(1+25*x.^2);
xx=linspace(-1,1,101);
yy=fun(xx);

nsp=0;
for np=[3,9,15]
   nsp=nsp+1;subplot(3,1,nsp);
   x=linspace(-1,1,np);
   fx=fun(x);
   pl=mkpl(x,fx);
   yyy=arrayfun(pl,xx);
   plot(xx,yy,xx,yyy);
   maxdiff=max(abs(yy-yyy));
   title(sprintf("piecewise linear\nnumf of points: %d\nmax difference: %.2f\n",np,maxdiff));
end



% assumption: t is equidistant (to have O(1) search)
% length(t) is at least 2
% t is increasing
function pl=mkpl(t,f)
   d=t(2)-t(1);
   a=t(1);
   %b=t(end);
   n=length(t);
   function y=pl0(x)
      k=floor((x-a)/d)+1;
      if k>=n; k=k-1; end % handle when x==b
      y=f(k)+(f(k)-f(k+1))/(t(k)-t(k+1))*(x-t(k));
   end
   pl=@pl0;
end