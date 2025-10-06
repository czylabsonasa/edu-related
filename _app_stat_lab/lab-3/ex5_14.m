% exercise 5.14, envelopes, winning cards, law of total probability

clc; clear; clf;

% exact computation
% by hand, : 
% P(win 500)=1/3*2/10+1/3*1/10+1/3*0

p_hand=1/3*2/10+1/3*1/10+1/3*0;

% approximate computation
% by simulation:
N=100000;

% i dont see a way to simulate w/o loop
% and this is not the most effective approach
sim=zeros(1,N);
for n=1:N
  switch(randi(3))
    case 1
      sim(n)=rand()<2/10;
    case 2
      sim(n)=rand()<1/10;
    case 3
      sim(n)=0;
  end
end

sim=cumsum(sim) ./ (1:N);

plot(1:N, sim, ".", [1,N],[p_hand, p_hand],"r");
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);

legend(["simulation", "theoretical"],"Location","northeastoutside");
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
title(sprintf("exercise 5.14\n envelopes, winning cards, law of total probability"));

