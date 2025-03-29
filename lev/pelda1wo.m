% ea: 7.oldal példa, vezeték

clear;
clf;clc;

fun=@(x) 250*sqrt(100+x.^2)+100*(20-x);
dfun=@(x) 250*x.*(100+x.^2).^(-0.5)-100;
ddfun=@(x) 250*((100+x.^2).^(-0.5)+(-0.5)*x.*(100+x.^2)^(-1.5));

a=0;b=20;
xx=linspace(a,b);
plot(xx, fun(xx));


[opt0,loc,status,info]=fminbnd(fun,a,b);
fprintf("fminbnd: %.5f %.5f\n",opt0,fun(opt0));
%info


%  ternáris keresés (az aranymetszéses "jobb", de ez egyszerűbb)
a=0;b=20;
tol=1e-8;
% (2/3)^step*(b-a)<tol -> step*log(2/3)+log(b-a)<log(tol)
S=ceil(log(tol/100)/log(2/3));
d=b-a;
for i=1:S
   aa=a+d/3; faa=fun(aa);
   bb=b-d/3; fbb=fun(bb);
   if faa<fbb
      b=bb;
   else
      a=aa;
   end
   d=d*2/3;
end
opt1=(a+b)/2;
fprintf("ternary: %.5f %.5f\n",opt1,fun(opt1));

% newton "pontosan"
a=0;b=20;
x=0.5*(a+b);
for k=1:10
   x=x-dfun(x)/ddfun(x);
end
opt2=x;
fprintf("newton: %.5f %.5f\n",opt2,fun(opt2));



% szelő közelítő deriváltakkal
a=0;b=20;
fp=mkdf(fun);
x0=0.5*(a+b);
f0=fp(x0);
x1=x0+0.1;
f1=fp(x1);
for k=1:10
   if abs(x1-x0)<1e-9 || abs(f0-f1)<1e-9, break;end
   x2=x1-fp(x1)*(x1-x0)/(f1-f0);
   f2=fp(x2);
   x0=x1; f0=f1;
   x1=x2; f1=f2;
end
opt3=x;
fprintf("kd-szelő: %.5f %.5f\n",opt3,fun(opt3));







% közelítő deriváltat ad vissza
function df=mkdf(f)
   tol=1e-9;
   function y=df0(x)
      h=1;
      y=0.5*(f(x+h)-f(x-h))/h;
      while true
         h=h/2;
         y0=y;
         y=0.5*(f(x+h)-f(x-h))/h;
         if abs(y0-y)<tol || abs(y0-y)<(1+abs(y))*tol; break; end
      end
   end
   df=@df0;
end
