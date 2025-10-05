% exercise 5.4, two dice, the sum is 7, given the sum is odd

clc; clear; clf;

% exact computation
% by hand, by definition: (6/36)/(18/36)=1/3
% in classical spaces, it can computed by 
% (favorable outcomes of AB) / (favourable outcomes of B) = 6/18

p_hand=1/3;

% approximate computation
% by simulation:
N=10000;

sim=sum(randi(6,2,N));
sim=sim(rem(sim,2)==1);
N=length(sim);
sim=cumsum(sim==7) ./ (1:N);

plot(1:N, sim, ".", [1,N],[p_hand, p_hand],"r");
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);

legend(["simulation", "theoretical"],"Location","northeastoutside");
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
title(sprintf("exercise 5.4\n two dice, the sum is 7, given the sum is odd"));

