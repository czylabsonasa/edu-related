% exercise 5.7, families w/ two children, there is a boy, given that there is a girl

clc; clear; clf;

% exact computation
% by hand, GG,GB,BB,BG each of them has 0.25 probabilty.
% P(AB)/P(B)=(2/4)/(3/4)=2/3

p_hand=2/3;

% approximate computation
% by simulation:
N=100000;

% G,B->1,2
% one family is one column
sim=randi(2,2,N);

% min, max,sum is columnwise for matrices
sim=sim(:, min(sim)==1);
[~,N]=size(sim);
sim=cumsum(max(sim)==2) ./ (1:N);

plot(1:N, sim, ".", [1,N],[p_hand, p_hand],"r");
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);

legend(["simulation", "theoretical"],"Location","northeastoutside");
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
title(sprintf("exercise 5.7\n families w/ two children, there is a boy, given that there is a girl"));

