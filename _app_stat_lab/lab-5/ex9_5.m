clc;clear;clf;

% 
% by hand approach: fix a number 0<d<1, and plot |x-y|<d
% geometric probability, you'll see the formula 
% what is P(1/2<RV<3/4)=?


% plot the obtained function
figure(1);
xx=linspace(0,1);
F=@(x) 1-(1-x).^2;
yy=F(xx);
plot(xx,yy,"b");
title(sprintf("exact: %.4f",F(3/4)-F(1/2)));
axis padded;



% by-simulation
figure(2);
N=100000;
x=rand(1,N);
y=rand(1,N);
RV=abs(x-y);
K=sum(RV>1/2 & RV<3/4);
ecdf(RV);
title(sprintf("simulation: %.4f",K/N));
axis padded;