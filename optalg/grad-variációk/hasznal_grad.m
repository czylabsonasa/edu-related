clf;
L0=@(x,y) x.^2+20*y.^2;
L=@(v) L0(v(1),v(2));

dL0=@(x,y) [2*x; 40*y];
dL=@(v) dL0(v(1),v(2));

[X,Y]=meshgrid(linspace(-3,3,22*2),linspace(-1,1,22*2));
Z=L0(X,Y);

w0=[-3;0.8];

subplot(3,2,1);
contour(X,Y,Z,22*2);
h=grad(L,dL,w0);
hold on;
plot(h(1,:),h(2,:),"*-");
title(sprintf("sima: %d",length(h)));


subplot(3,2,2);
contour(X,Y,Z,22*2);
h=mom_grad(L,dL,w0,0.5);
hold on;
plot(h(1,:),h(2,:),"*-");
title(sprintf("mom: %d",length(h)));

subplot(3,2,3);
contour(X,Y,Z,22*2);
h=adagrad_grad(L,dL,w0,1);
hold on;
plot(h(1,:),h(2,:),"*-");
title(sprintf("adagrad: %d",length(h)));

subplot(3,2,4);
contour(X,Y,Z,22*2);
h=rmsprop_grad(L,dL,w0,0.5);
hold on;
plot(h(1,:),h(2,:),"*-");
title(sprintf("rmsprop: %d",length(h)));

subplot(3,2,5);
contour(X,Y,Z,22*2);
h=adam_grad(L,dL,w0,0.5,0.5);
hold on;
plot(h(1,:),h(2,:),"*-");
title(sprintf("adam: %d",length(h)));


