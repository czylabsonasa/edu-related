clc; clear; clf;

tit="exercise 6.1\nhead/tail, independence";

% exact computation
% by hand 
% A: both, 
% B: at most 1 tail
% AB: 
pA=1-2/2^10;
pB=(1+10)/2^10;
pAB=10/2^10;

q_hand=pAB/(pA*pB); % 1 
d_hand=pAB-(pA*pB); % 0

% approximate computation
% by simulation:
N=1000000;

sim=randi(2,10,N)-1;
kA=sum(sim)>0 & sum(sim)<10;
kB=sum(sim)<2;
kAB=kA & kB;
sA=cumsum(kA) ./ (1:N);
sB=cumsum(kB) ./ (1:N);
sAB=cumsum(kAB) ./ (1:N);




figure(1);
simplot(sAB ./ (sA.*sB),q_hand,tit+"\n p(AB) / (P(A)P(B))");

figure(2);
simplot(sAB - (sA.*sB),d_hand,tit+"\n p(AB) - (P(A)P(B))");


