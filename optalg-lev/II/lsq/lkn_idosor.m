%clear;
%clf;clc;close all;

y=dlmread("idosor.txt");
N=length(y);
t=(1:N)';


plot(t,y);

N0=80;
I=(1:(N0-3))';

A=y([I+2, I+1, I]);
b=y(I+3);
alfa=(A'*A)\(A'*b);

yb=y;
for k=(N0+1):N
  yb(k)=alfa'*yb(k-1:-1:k-3);
end
hold on;
plot(t(N0+1:N),yb(N0+1:N),'r')
xlim([-5,105]);




