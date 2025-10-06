% exercise 4.2, randomly broken stick + a 0.5 length one, triangle

clc; clear; clf;

% exact computation
% write down the triangle inequalities for x,1-x,0.5 --> 0.25 < x < 0.75
% by hand, favourable area / total area = (0.75-0.25)/1

p_hand=1/2;

% approximate computation
% by simulation:
N=100000;

% N random points on a unit square
sim=rand(1,N);
% a matrix will be sorted column-wise
sim=sort([sim; 1-sim; ones(1,N)*0.5]);
sim=sim(1,:)+sim(2,:)>sim(3,:);
sim=cumsum(sim) ./ (1:N);
plot(1:N, sim, ".", [1,N],[p_hand, p_hand],"r");
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);

legend(["simulation", "theoretical"],"Location","northeastoutside");
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
title(sprintf("exercise 4.2\n randomly broken stick + a 0.5 length one, triangle"));

