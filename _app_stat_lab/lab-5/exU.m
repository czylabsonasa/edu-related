clc;clear;clf;

% 
% by hand approach: we know the cdf everything can be computed


% by-hand (theoretical)
figure(1);
a=1; b=12;
xx=linspace(a,b);
F=@(x) (x-b)/(b-a);
yy=F(xx);
plot(xx,yy);
title(sprintf("exact - mean:%.4f var:%.4f P=%.4f",(a+b)/2,(b-a)^2/12,F(8)-F(1)));
axis padded;



% by-simulation
figure(2);
N=100000;
RV=11*rand(1,N)+1;
ecdf(RV);
K=sum(RV<=8);
title(sprintf("ecdf - mean:%.4f var:%.4f P=%.4f",mean(RV),var(RV),K/N));
axis padded;