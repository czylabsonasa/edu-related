% exercise 5.5, two dice, at least one six, given they are different

clc; clear; clf;

% exact computation
% by hand, (6,5),...,(6,1)->#5->total #10 -> (10/36)/((36-6)/36)=1/3

p_hand=1/3;

% approximate computation
% by simulation:
N=10000;

sim=randi(6,2,N);
sim=sim(:,sim(1,:)~=sim(2,:));
[~,N]=size(sim);
sim=cumsum(max(sim)==6) ./ (1:N);

plot(1:N, sim, ".", [1,N],[p_hand, p_hand],"r");
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);

legend(["simulation", "theoretical"],"Location","northeastoutside");
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
title(sprintf("exercise 5.5\n two dice, at least one six, given they are different"));

