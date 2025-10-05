% exercise 4.1, square w/ inscribed circle - shot outside the circle

clc; clear; clf;

% exact computation
% by hand, favourable area / total area = (1-pi*0.5^2)/1

p_hand=1-pi/4;

% approximate computation
% by simulation:
N=100000;

% N random points on a unit square
sim=cumsum(sum((rand(2,N)-0.5).^2)>0.5^2) ./ (1:N);
plot(1:N, sim, ".", [1,N],[p_hand, p_hand],"r");
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);

legend(["simulation", "theoretical"],"Location","northeastoutside");
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
title(sprintf("exercise 4.1\n square w/ inscribed circle - shot outside the circle"));

