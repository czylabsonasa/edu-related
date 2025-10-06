clc;clear;clf;

% 
% by hand approach: we know the cdf everything can be computed
% at least by calling appropriate functions


% by-hand (theoretical)
figure(1);
xx=linspace(-3,3);
f=@(x) ?
F=@(x) ?
yy=f(xx);
plot(xx,yy);
title(sprintf("exact - P=%.4f",));
axis padded;



% by-simulation
figure(2);
N=100000;
RV=?;
ecdf(RV);
K=?;
title(sprintf("ecdf - P=%.4f",K/N));
axis padded;