% 10. feladat
clear;
clf;
close all;



td=[1.2 3.6 4 5.5 8.4 10.2 13.1];
td=td';
yd=[36.08 30.48 29.63 26.67 21.75 19.16 15.63];
yd=yd';

F=@(v,t) v(1) * exp(-v(2)*t);

par=lsqcurvefit(F, [1,1]', td, yd)

% G=@(v) F(v,td)-yd;
% par2=lsqnonlin(G,[1,1]')

f=@(t) F(par,t) ; % specializalas

figure(1);
plot(td,yd,'r*');
hold on;
tt=linspace(min(td)-1,max(td)+1);
plot(tt,f(tt),'b');
felez=f(0)/2
par(1)/2


% vagy Gauss normal egyenlettel vagy polyfit-tel
% log transzformaciot kell alkalmazni


