clc;clear;
opts=optimoptions("fminunc","Display","off");
%opts=optimset("Display","off");

% f=@(x,y) x.^2+3*x.*y+y.^2-x+y;
% c1=@(x,y) x.^2+y.^2-1/9;
% pen=@(v) c1(v(1),v(2))^2+c2(v(1),v(2))^2;
% x0=[1/3;1/3];


% linear ineq constraint
% f=@(x,y)100*(y-x.^2).^2 + (1-x).^2;
% c1=@(x,y) max(0,x+2*y-1); % <=0-t fejezi ki
% pen=@(v) c1(v(1),v(2))^2;
% x0=[-1;2];

% linear ineq constraint + equality
% f=@(x,y)100*(y-x.^2).^2 + (1-x).^2;
% c1=@(x,y) max(0,x+2*y-1); % <=0-t fejezi ki
% c2=@(x,y) 2*x+y-1;
% pen=@(v) c1(v(1),v(2))^2+c2(v(1),v(2))^2;
% x0=[0.5;0];

% bounds
% f = @(x,y)1+x./(1+y)-3*x.*y+y.*(1+x);
% LO=[0;0]; UP=[1;2];
% c1=@(v) (LO-v>0)'*(LO-v)+(v-UP>0)'*(v-UP);
% pen=@(v) c1(v)^2;
% x0=(LO+UP)/2;


% bounds+nonlinear
f=@(x,y)100*(y-x.^2).^2 + (1-x).^2;
LO=[0;0.2]; 
UP=[0.5;0.8];
c1=@(v) (LO-v>0)'*(LO-v)+(v-UP>0)'*(v-UP);
c2=@(v) max(0,(v(1)-1/3)^2+(v(2)-1/3)^2-(1/3)^2);
pen=@(v) c1(v)^2+c2(v)^2;
x0=[1/4;1/4];
%x0=(LO+UP)/2;


F=@(v) f(v(1),v(2));
alfa=0.5;
while true
   Fpen=@(v) F(v)+alfa*pen(v);
   [xopt,~,status]=fminunc(Fpen,x0,opts);
   if status>0 
      if pen(xopt)<1e-15
         st="succ";
         break;
      end
      x0=xopt;
   end
   alfa=2*alfa;
   if alfa>10^100
      st="fail";
      break;
   end
end
st
alfa
xopt
pen_final=pen(x0)



