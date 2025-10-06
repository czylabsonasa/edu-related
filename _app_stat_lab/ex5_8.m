% exercise 5.8, points from a square, x,y<0.5, given |x-y|<0.5

clc; clear; clf;

% exact computation
% by hand, after plotting: 
% P(AB)/P(B)=(1/4)/(3/4)=1/3

p_hand=1/3;

% approximate computation
% by simulation:
N=100000;

% the columns are the points
sim=rand(2,N);

% min, max,sum is columnwise for matrices
sim=sim(:, abs(sim(1,:)-sim(2,:))<0.5);

[~,N]=size(sim);
sim=cumsum(max(sim)<0.5) ./ (1:N);

plot(1:N, sim, ".", [1,N],[p_hand, p_hand],"r");
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);

legend(["simulation", "theoretical"],"Location","northeastoutside");
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
title(sprintf("exercise 5.8\n points from a square, x,y<0.5, given that |x-y|<0.5"));

