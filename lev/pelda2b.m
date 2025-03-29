% ea: 8.oldal példa (téglatest)
% contour+history

clear;clf;clc;
hold on;

fun0=@(x,y) 2*x.*y + 2000./x + 2000./y;
fun=@(v) fun0(v(1),v(2));


[X,Y]=meshgrid(linspace(5,15,33),linspace(5,15,33));
Z=fun0(X,Y);
contour(X,Y,Z,33);

% a standard way to get the history of points
% https://ch.mathworks.com/help/matlab/math/output-functions.html
[outfun,geth]=mkoutfun();
theoptions = optimset("OutputFcn", outfun);

rng(22222);
x0=5+10*rand(2,1);
plot(x0(1),x0(2),"kO");
%[loc,val,status,info]=fminsearch(fun,x0);
[loc,val,status,info]=fminunc(fun,x0,theoptions);
loc
val
info

plot(loc(1),loc(2),"kO");
history=geth();
plot(history(1,:),history(2,:),"ko-","MarkerSize",4);

axis equal;
hold off;



function [outfun,geth]=mkoutfun()
   history=[];
   function stop = outfun0(x,optimvalues,state)
      stop = false;
      if isequal(state,'iter')
         history = [history, x];
      end
   end
   function h=geth0()
      h=history;
   end
   outfun=@outfun0;
   geth=@geth0;
end