### lab-5

- [the slides](5-General-Rv.pdf)


#### is it a cdf?
```matlab
clc;clear;clf;

% is it a cdf?
% by hand approach: check the extrem locations: limits + connection points 
% in case of piecewise defined functions

% by-hand approach
% a) (x-1)/(x+1) if x>=1/2, otherwise 0
% not a cdf: it negative at 1/2

% practical approach
figure(1);
xx=linspace(1/2,5);
plot([-1,1/2],[0,0],"b",xx,(xx-1)./(xx+1),"b",[-1,5],[1,1],"r");
axis padded;



% by-hand approach
% a) (x-1)/(x+1) if x>=1, otherwise 0
% it is cdf

% practical approach
figure(2);
xx=linspace(1,5);
plot([-1,1],[0,0],"b",xx,(xx-1)./(xx+1),"b",[-1,5],[1,1],"r");
axis padded;

```


#### what is the cdf,geometric prob.
```matlab
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
```


