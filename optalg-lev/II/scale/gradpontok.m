clc;

P=dlmread("pontok.csv");
x=P(:,1);
y=P(:,2);
z=P(:,3);
%plot(P(1,:),P(2,:),'*');


rng(222);
w0=rand(3,1)-0.5; % common starting guess

disp("not scaled")
disp("   Gauss");
M=length(x);
rA=[ones(M,1),x,y];
opt_w=(rA'*rA)\(rA'*z);
disp(opt_w);

disp("   grad")
A=[ones(M,1), x, y];
AtA=A'*A;
btb=z'*z;
Atb=A'*z;
F=@(x)(x'*AtA*x-2*x'*Atb+btb)/M;
dF=@(x) 2*(AtA*x-Atb)/M;
[w,status,iter]=yourgrad(w0,F,dF);
disp(w);
disp(iter);


disp("scaled");
disp("   Gauss")
mx=mean(P(:,1)); sx=std(P(:,1));
my=mean(P(:,2)); sy=std(P(:,2));
scalex=@(x) (x-mx)/sx;
scaley=@(y) (y-my)/sy;
x=scalex(x);
y=scaley(y);

A=[ones(M,1), x, y];
AtA=A'*A;
btb=z'*z;
Atb=A'*z;
F=@(x)(x'*AtA*x-2*x'*Atb+btb)/M;
dF=@(x) 2*(AtA*x-Atb)/M;

sc_opt_w=AtA\Atb;
disp(sc_opt_w)

disp("   grad")
[w,status,iter]=yourgrad(w0,F,dF);
disp(w)
disp(iter)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

