### lab-3

#### the slides
- [3-Bayes](3-Bayes.pdf)


#### 5.4
```matlab
% exercise 5.4, two dice, the sum is 7, given the sum is odd

clc; clear; clf;

% exact computation
% by hand, by definition: (6/36)/(18/36)=1/3
% in classical spaces, it can computed by 
% (favorable outcomes of AB) / (favourable outcomes of B) = 6/18

p_hand=1/3;

% approximate computation
% by simulation:
N=10000;

sim=sum(randi(6,2,N));
sim=sim(rem(sim,2)==1);
N=length(sim);
sim=cumsum(sim==7) ./ (1:N);

plot(1:N, sim, ".", [1,N],[p_hand, p_hand],"r");
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);

legend(["simulation", "theoretical"],"Location","northeastoutside");
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
title(sprintf("exercise 5.4\n two dice, the sum is 7, given the sum is odd"));


```


#### 5.5
```matlab
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


```


#### 5.7
```matlab
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


```


#### 5.8
```matlab
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


```


#### 5.14
```matlab
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


```


#### 5.19
```matlab
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

```


#### 5.22
```matlab
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

```

