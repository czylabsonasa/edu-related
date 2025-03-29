% ea: 13.oldal példa (1-kör feladat, minimális sugarú lefedő kör keresése)

clear;clf;clc;
hold on;

% a pontok
P=[2.5 0 4 1; 0 0 3 4];


fun=@(v) ...
fun0=@(x,y) fun([x;y]);


[X,Y]=meshgrid(...
   linspace(min(P(1,:)),max(P(1,:)),33),...
   linspace(min(P(2,:)),max(P(2,:)),33));
Z=arrayfun(fun0,X,Y);
contour(X,Y,Z,33);


[outfun,geth]=mkoutfun();
theoptions = optimset("OutputFcn", outfun);

rng(2222);
i=randi(33);j=randi(33);
x0=[X(i,j);Y(i,j)];
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