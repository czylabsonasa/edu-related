% exercise 3.1

clc; clear; clf;

% exact computations
% by hand: (6,2),(5,3),...,(2,6)-> 5 different outcomes -> 5/36
p_hand=5/36;
% by computer:
tmp=((1:6)+(1:6)')==8;
p_comp=sum(tmp(:))/36;
assert(p_hand==p_comp);

% approximate computation
% by simulation:
N=100000;
tmp=randi(6,N,2);
sim=cumsum((tmp(:,1)+tmp(:,2))==8)./(1:N)';

% plot the results (getting a taste of the asymptotic behaviour)
plot(1:N, sim, ".",[1,N],[p_hand, p_hand]);
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
legend(["simulation", "theoretical"],"Location","northeastoutside");
title("exercise 3.1 two dice\n the sum is 8");
