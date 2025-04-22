clear;
clf;
close all;

td=0:0.5:10;
td=td';

yd=[-0.155 -1.079 0.086 0.887...
  -0.037 -0.728 0.003 0.596 0.020...
  -0.487 -0.035 0.397 0.043 -0.324 ...
  -0.048  0.264 0.049 -0.214 -0.048 0.173 0.046];
yd=yd';

length(td)
length(yd)

fun=@(x,t) x(1)*exp(x(2)*t).*cos(x(3)*t+x(4));

par=lsqcurvefit(fun,[1,1,1,1]',td,yd)

fun2=@(x) fun(x,td)-yd
par2=lsqnonlin(fun2,[1,1,1,1]')

norm(par-par2)


sol=@(t) fun(par,t);
xx=linspace(-0.5,10.5);
plot(td,yd,'r*',xx,sol(xx),'b')

norm(sol(td)-yd)