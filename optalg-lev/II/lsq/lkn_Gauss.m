% lkn-Gauss A
clc;clear;clf;
hold on;

rng(222);
t=6*rand(20,1)-3;
fun=@(x) 1+2*cos(3*x)-3*sin(2*x);
f=fun(t);
ff=f+randn(size(t));
xx=linspace(-3,3);
subplot(3,1,1);
hold on;
plot(t,ff,"*b");
plot(xx,fun(xx),"r");
title("eredeti");

A=[ones(size(t)), cos(3*t), sin(2*t)];
c=(A'*A)\(A'*ff);
lkn_fun=@(x) c(1)+c(2)*cos(3*x)+c(3)*sin(2*x);
subplot(3,1,2);
hold on;
plot(t,ff,"*b");
plot(xx,lkn_fun(xx),"k");
title("lkn");

subplot(3,1,3);
hold on;
plot(xx,fun(xx),"r");
plot(xx,lkn_fun(xx),"k");
title("eredeti vs lkn");


hold off;