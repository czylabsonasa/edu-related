% exercise 3.7, women, men, round table

clc; clear; clf;

% exact computation
% by hand
p_hand=factorial(4)*factorial(5)/factorial(9);

% approximate computation
% by simulation:

tmp=zeros(1,11);
urn=[ones(1,5), zeros(1,5)];
N=100000;
K=0;
sim=zeros(1,N);
for n=1:N
  tmp(1:10)=datasample(urn, 10, "Replace",false);
  % make it round
  tmp(end)=tmp(1); 
  sim(n)=~any(diff(tmp)==0);
end
sim=cumsum(sim)./(1:N);

% plot the results (getting a taste of the asymptotic behaviour)
plot(1:N, sim, ".",[1,N],[p_hand, p_hand]);
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
legend(["simulation", "theoretical"],"Location","northeastoutside");
title(sprintf("exercise 3.7 round table\n 5 women, 5 men"));
