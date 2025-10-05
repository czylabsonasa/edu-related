% exercise 3.2

clc; clear; clf;

% exact computations
% by hand: 6->#5, 5->#4,...,2->#1  ---> 15 different outcomes -> 15/36
p_hand=15/36;
% by computer:
tmp=(1:6)-(1:6)';
p_comp=sum(tmp(:)>0)/36;
assert(p_hand==p_comp);

% approximate computation
% by simulation:
N=100000;
tmp=randi(6,N,2);
sim=cumsum(tmp(:,1)>tmp(:,2))./(1:N)';

% plot the results (getting a taste of the asymptotic behaviour)
plot(1:N, sim, ".",[1,N],[p_hand, p_hand]);
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
legend(["simulation", "theoretical"],"Location","northeastoutside");
title("exercise 3.2 two dice\n the first > second");
