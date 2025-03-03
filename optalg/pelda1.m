clc; clear; clf;
% 1. példa, vezeték
% 1-változós, fminbnd
% [x,fval,exitflag,output] = fminbnd(fun,x1,x2,options)
%
% fun=@(x) 250*sqrt(10^2+x.^2)+100*(20-x);
% [loc,val,exitflag,output] = fminbnd(fun, 0,20, optimset("Display","iter"));
% xx=linspace(0,20);
% yy=fun(xx);
% plot(xx,yy,loc,val,"r*")


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 1. példa, vezeték, OutputFcn, nested function
% https://ch.mathworks.com/help/matlab/math/output-functions.html
%
% fun=@(x) 250*sqrt(10^2+x.^2)+100*(20-x);
% xx=linspace(0,20);
% yy=fun(xx);
% hold on;
% plot(xx,yy)
% [loc, val, myhistory] = myproblem(fun,0,20);
% plot(myhistory,fun(myhistory),"ro-")
% plot(loc,val,"kx")
% function [loc,val,myhistory] = myproblem(fun, x0,x1)
%    myhistory = [];
%    myoptions = optimset("OutputFcn", @myoutput,"Display","iter");
%    [loc,val] = fminbnd(fun, x0,x1, myoptions);
% 
%    function stop = myoutput(x,optimvalues,state);
%       stop = false;
%       if isequal(state,'iter')
%          myhistory = [myhistory; x];
%       end
%    end
% end
% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 2.példa, téglatest
% 2-változőssá alakítani
% -> a Display/iter nem adja meg apontokat, mint az 1-változósnál
%
% fun0=@(x1,x2) 2*x1.*x2 + 2000./x1 + 2000./x2;
% % a többváltozós módszerek vektorparaméterű fv-t várnak
% fun=@(x) fun0(x(1),x(2)); 
% [loc, val, exitflag, output] = fminunc(fun, [10,20], optimset("Display","iter"));
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 2. példa: kijön a számtani mértani egyenlőtlenségből is
% -> feladat


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 2 példa, rajz
% a linspace 2-valtozós megfelelője
% [XX,YY]=meshgrid(xx,yy)
% contour(XX,YY,ZZ), szintvonalak
%
% fun0=@(x1,x2) 2*x1.*x2 + 2000./x1 + 2000./x2;
% fun=@(x) fun0(x(1),x(2)); 
% % tudjuk hogy 10,10 optimális hely
% xx=linspace(5,15);
% yy=xx;
% [XX,YY]=meshgrid(xx,yy);
% ZZ=fun0(XX,YY);
% figure(1);
% mesh(XX,YY,ZZ);
% figure(2);
% contour(XX,YY,ZZ,50);
% hold on;
% plot(10,10,"kX")


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 2 példa, kontúr + lépések, outputFcn
%
% fun0=@(x1,x2) 2*x1.*x2 + 2000./x1 + 2000./x2;
% fun=@(x) fun0(x(1),x(2)); 
% % tudjuk hogy 10,10 optimális hely
% xx=linspace(5,15);
% yy=xx;
% [XX,YY]=meshgrid(xx,yy);
% ZZ=fun0(XX,YY);
% contour(XX,YY,ZZ,50);
% hold on;
% fun=@(x) fun0(x(1),x(2)); 
% % oszlopvektort adunk meg kezdetnek
% [loc, val, myhistory] = myproblem(fun,[8;12]);
% plot(myhistory(1,:),myhistory(2,:),"ro-")
% plot(loc(1),loc(2),"kx")
% 
% function [loc,val,myhistory] = myproblem(fun,x0)
%    myhistory = [];
%    myoptions = optimset("OutputFcn", @myoutput,"Display","iter");
%    [loc,val] = fminunc(fun,x0,myoptions);
% 
%    function stop = myoutput(x,optimvalues,state);
%       stop = false;
%       if isequal(state,'iter')
%          % oszlopok egymás mellé rakása
%          myhistory = [myhistory, x];
%       end
%    end
% end
% 
% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%
% 3. példa - Fermat-Weber
%
% -> feladat a fentiek alapján
%


%
% 4. példa - Kör-elhelyezés, minimális tartalmazó kör keresése
%
% -> feladat a fentiek alapján
%


%
% 5. Minimális felület, peremfeltételekkel
%


