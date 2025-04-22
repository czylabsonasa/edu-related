clear;
clf;
close all;

t=[0.1 0.5 1.2 1.5 2 2.1 2.4 3 3.2];
t=t';
y=[-0.6 1.5 2.5 2.9 3.2 3.3 3.5 3.8 3.9];
y=y';

par=lsqcurvefit(@mbateman,[1,2,1]',t,y)

fun2=@(p) mbateman(p,t)-y;
par2=lsqnonlin(fun2,[1 2 1]')



sol=@(t) mbateman(par,t);

xx=linspace(0,3.5);
plot(t,y,'r*',xx,sol(xx),'b');


% kenyelmesebb mint kulon file-ban
function y=mbateman(p,t)
  if p(1)==p(2)
    y=p(3)*p(1)*exp(-p(1)*t);
  else
    y=p(3)*p(1)*(exp(-p(1)*t)-exp(-p(2)*t))/(p(2)-p(1));
  end
end