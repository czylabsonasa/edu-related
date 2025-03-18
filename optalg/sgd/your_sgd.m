clear;clc;
figure(1);clf(1);

Q=dlmread("pontok200E.txt");
Q=Q';
[~,M]=size(Q);
%assert(M==200);

fun=@(w,x,y) w(1)*sin(pi*x)*exp(-w(2)*x^2-w(3)*y^2);
dfun=@(w,x,y) [sin(pi*x)*exp(-w(2)*x^2-w(3)*y^2);...
    w(1)*sin(pi*x)*exp(-w(2)*x^2-w(3)*y^2)*(-x^2); ...
    w(1)*sin(pi*x)*exp(-w(2)*x^2-w(3)*y^2)*(-y^2)];

Lq=@(w,q) (fun(w,q(1),q(2))-q(3))^2;
dLq=@(w,q) 2*(fun(w,q(1),q(2))-q(3))*dfun(w,q(1),q(2));

L=mkL(Lq,Q,M);
dL=mkdL(dLq,Q,M);

RNG=2222;
rng(RNG);

w0=2*(rand(3,1)-0.5);
opt_w=lsqnonlin(L, w0);

a=0.5;
E=20;
B=10;
w=w0;
history=[L(w)];
for e=1:E
    I=randperm(M);
    for i=1:B:M
        g=[0;0;0];
        for q=Q(:,I(i:i+B-1))
            g=g+dLq(w,q);
        end
        g=g/B;
    end
    w=w-a*g;
    history=[history,L(w)];
end
plot(history)
hold on
L_opt=L(opt_w);
plot([1,E+1],[L_opt,L_opt]);
title(sprintf( ...
   "sgd\nRNG=%d\na=%.3f B=%d E=%d\nvs.lsqnonlin=%.3f",...
   RNG,a,B,E,abs(history(end)-L_opt)));











function L=mkL(Lq,Q,M)
    function y=L0(w)
        y=0;
        for q=Q
            y=y+Lq(w,q);
        end
        y=y/M;
    end
    L=@L0;
end

function dL=mkdL(dLq,Q,M)
    function y=dL0(w)
        y=0;
        for q=Q
            y=y+dLq(w,q);
        end
        y=y/M;
    end
    dL=@dL0;
end


