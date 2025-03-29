% generate non-symmetrical points on the plane
nP=222;
exact=randi(10,1,3)-5;
plan= @(x,y) exact(1)+exact(2)*x+exact(3)*y;
Px = randi(100,nP,1)-50;
Py = randi(200,nP,1)-100;
P=[Px,Py]*[cos(pi/6),-sin(pi/6);sin(pi/6),cos(pi/6)];

P=round([P, plan(Px,Py)+randn(nP,1)],4);
dlmwrite("pontok.csv",P);

