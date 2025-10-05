% exercise 5.19 factories, cars, Bayes

clc; clear; clf;

% exact computation
% by hand 
% factory weights
p_fact=[200,320,270,210]; p_fact=p_fact/sum(p_fact);
% ok weights
p_ok=1-[2,5,3,1]/100;

% Bayes theorem (weight of perfect cars from factory 4 / total weight of perfect cars)
p_hand=p_fact(4)*p_ok(4)/dot(p_fact,p_ok);

% approximate computation
% by simulation:
N=100000;

% simulate w/ loop
rN=0; % it is the real N, counting only the perfect cars
sim=zeros(1,N);
for f=datasample(1:4,N,"Weights",p_fact)
  if rand()<p_ok(f)
    rN=rN+1;
    sim(rN)=(f==4);
  end
end

% adjust
sim=sim(1:rN);
N=rN;

sim=cumsum(sim) ./ (1:N);

plot(1:N, sim, ".", [1,N],[p_hand, p_hand],"r");
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);

legend(["simulation", "theoretical"],"Location","northeastoutside");
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
title(sprintf("exercise 5.19\n factories, cars, Bayes"));
%drawnow; % uncomment this line and press ctrl+enter, and you will see several
%simulation results one by one
