% exercise 3.17, lottery, hit at least 3
% for it is slow for large N, it is better to plot the partial results to
% see the process 
% --> see: help drawnow

clc; clear; clf;

% exact computation
% by hand
% prob of having an exact k hit:
h=@(k) nchoosek(5,k)*nchoosek(85,5-k)/nchoosek(90,5);

p_hand=h(3)+h(4)+h(5);

% approximate computation
% by simulation:
N=100000;

hold on;
plot([1,N],[p_hand, p_hand],"r");
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);


prev=0;
K=0;
sim=zeros(1,N);
for n=1:N
  %win=datasample(1:90, 5, Replace=false);
  %you=datasample(1:90, 5, Replace=false);
  % N must be divisible by 100!!!
  if rem(n,100)==0
    tmp=cumsum(sim(n-100+1:n))+prev;
    prev=tmp(end);
    plot(n-100+1:n, tmp./(n-100+1:n), "b.");drawnow;
  end
  win=randsample(90, 5, false);
  you=randsample(90, 5, false);
  sim(n)=length(intersect(win,you))>2;
end

legend(["simulation", "theoretical"],"Location","northeastoutside");
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
title(sprintf("exercise 3.17 5 from 90 lottery \n hit at least 3"));

hold off;
