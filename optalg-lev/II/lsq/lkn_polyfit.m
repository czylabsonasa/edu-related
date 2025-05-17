% lkn-polyfit
clc;clear;clf;
hold on;

rng(222);
t=6*rand(20,1)-3;
p=[1,-3,-2,1,4]';
f=polyval(p,t);
ff=f+2*randn(size(t));
xx=linspace(-3,3);
subplot(3,1,1);
hold on;
plot(t,ff,"*b");
plot(xx,polyval(p,xx),"r");
title("eredeti");

pp=polyfit(t,ff,length(p)-1);
subplot(3,1,2);
hold on;
plot(t,ff,"*b");
plot(xx,polyval(pp,xx),"k");
title("lkn");

subplot(3,1,3);
hold on;
plot(xx,polyval(p,xx),"r");
plot(xx,polyval(pp,xx),"k");
title("eredeti vs lkn");


hold off;