% Gauss random walk
clf; clear; clc;

STEP=222;
alfa=2*pi*rand(1,STEP);
vec=[cos(alfa);sin(alfa)];
how="b.";
myplot=@(x,y) plot(x,y,how,"MarkerSize",3);

subplot(2,2,1);
hold on
steps=randn(1,STEP);
path=vec.*steps;
%path=min(max(path,LO),UP);
myplot(path(1,:),path(2,:));
axis equal;

subplot(2,2,2);
hold on;
steps=sqrt(12)*rand(1,STEP)-sqrt(12)/2;
path=vec.*steps;
%path=min(max(path,LO),UP);
myplot(path(1,:),path(2,:));
axis equal;

subplot(2,2,3);
hold on;
steps=exprnd(1,1,STEP);
path=vec.*steps;
myplot(path(1,:),path(2,:));
axis equal;

mu=1.8;
subplot(2,2,4);
hold on;
U=rand(1,STEP);
steps=exp(log(mu/(mu-1)*U)/(-mu))-1;
path=vec.*steps;
myplot(path(1,:),path(2,:));
axis equal;



for p=1:4
   subplot(2,2,p);
   axis([-5,5,-5,5]);
end


