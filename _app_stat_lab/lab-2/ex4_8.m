% exercise 4.8, two ships, none of them waits

clc; clear; clf;

% exact computation

% by hand, favourable area / total area = (23^2/2 + 22^2/2)/24^2
p_hand=(23^2/2 + 22^2/2)/24^2;

% approximate computation
% by simulation:
N=100000;

% the arrivals
A=24*rand(1,N);
B=24*rand(1,N);
sim=cumsum((A+1<B) | (B+2<A)) ./ (1:N);
plot(1:N, sim, ".", [1,N],[p_hand, p_hand],"r");
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);

legend(["simulation", "theoretical"],"Location","northeastoutside");
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
title(sprintf("exercise 4.8\n two ships, none of them waits"));

