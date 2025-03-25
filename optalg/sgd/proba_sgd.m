clf;
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

w0=rand(3,1)-0.5;
optloc=lsqnonlin(L, w0);
optval=L(optloc);

a=0.2;
E=100;
B=20;
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
plot([1,E],[optval,optval])
title(sprintf(...
    "vs.lsqnonlin %.3f",abs(history(end)-optval)));












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


