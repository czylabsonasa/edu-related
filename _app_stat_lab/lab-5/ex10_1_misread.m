clc;clear;clf;

% 
% by hand approach: knowing the cdf means that you also know the pdf
% sieve formula, P(min(x,y)<d)=P(x<d + y<d)=P(x<d)+P(y<d)-P(x<d*y<d)
% getting the pdf: take the derivative
% 
% 


% plot the obtained cdf
figure(1);
xx=linspace(0,2);
F=@(x) x/2+x/2-(x/2).*(x/2);
yy=F(xx);
subplot(2,1,1);
plot(xx,yy,"b");
title(sprintf("exact: %.4f",F(3/4)-F(1/2)));
axis padded;

subplot(2,1,2);
f=@(x)1-x/2;
yy=f(xx);
plot(xx,yy,"b");
title(sprintf("pdf"));
axis padded;






% by-simulation
figure(2);
N=100000;
x=2*rand(1,N);
y=2*rand(1,N);
RV=min(x,y);
ecdf(RV);
K=sum(RV>1/2 & RV<3/4);
title(sprintf("ecdf: %.4f",K/N));
axis padded;