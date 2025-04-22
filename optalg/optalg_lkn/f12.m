% 12. feladat

clear;
clf;
close all;


n=200;
t=linspace(0,10,n);
t=t';
y0=sin(2*t)+sin(3*t);
yz=y0+0.1*randn(size(y0));

plot(t,y0,'b', t, yz, 'r' )

lam=2;
D=diag(-ones(1,n-1),1)+eye(n);
D=D(1:end-1,:);
A=[eye(n); sqrt(lam)*D];
b=[yz; zeros(n-1,1)];
x=(A'*A)\(A'*b);

hold on
plot(t,x,'k')






