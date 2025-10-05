clc; clear; clf;

tit="exercise 5.22\nUlysses, triple turnout, Bayes";

% exact computation
% by hand 
% weights for the possibilities
p_B=[1,1,1]/3; 
% conditional weights of success
p_AB=1-[2/3,1/2,0];

% Bayes theorem 
p_hand=p_B(1)*p_AB(1)/dot(p_B,p_AB);

% approximate computation
% by simulation:
N=100000;

% simulate w/ loop
rN=0; % it will be the real N, counting only the "success" cases
sim=zeros(1,N);
for tmp=datasample(1:3,N,"Weights",p_B)
  if rand()<p_AB(tmp)
    rN=rN+1;
    sim(rN)=(tmp==1);
  end
end

% adjust
sim=sim(1:rN); N=rN;
sim=cumsum(sim) ./ (1:N);

simplot(sim,p_hand,tit); %drawnow is included
