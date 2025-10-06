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


#### what is the cdf? (geometric prob.)
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


#### what is the cdf again? (geometric prob).
```matlab
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
```


#### uniform distribution
```matlab
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
```


#### normal distribution
```matlab
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
```


#### discrete rv, properties
```matlab
clc;clear;clf;

% 
% by hand approach: we know the pd of the rv: everything can be computed
% see: the function piecewise


% by-hand (theoretical)
figure(1);
?
xx=
F=@(x) ?
yy=f(xx);
plot(xx,yy);
title(sprintf("exact - P=%.4f",);
axis padded;



% by-simulation
figure(2);
N=100000;
RV=?;
ecdf(RV);
K=?;
title(sprintf("ecdf - P=%.4f",K/N));
axis padded;

```





