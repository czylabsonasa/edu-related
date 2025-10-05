% exercise 3.14b, w/o replacement

clc; clear; clf;

% exact computation
% by hand
p_hand=nchoosek(20,4)*nchoosek(30,10-4)/nchoosek(50,10);

% approximate computation
% by simulation:

urn=[ones(1,20), zeros(1,30)];
N=10000;
K=0;
sim=zeros(1,N);
for n=1:N
  % red: 1, white 0
  % datasample is convenient, but slow
  tmp=datasample(urn, 10, "Replace",false);
  %randsample is sligthly faster
  %tmp=urn(randsample(50,10, false));
  sim(n)=(sum(tmp)==4);
end
sim=cumsum(sim)./(1:N);

% plot the results (getting a taste of the asymptotic behaviour)
plot(1:N, sim, ".",[1,N],[p_hand, p_hand]);
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
legend(["simulation", "theoretical"],"Location","northeastoutside");
title(sprintf("exercise 3.14b urn\n 20 red, 30 white, 10 chosen w/o replacement. \n got 4 reds."));
