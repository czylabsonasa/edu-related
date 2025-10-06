### lab-2

- [the slides](2-Class-Prob.pdf)


#### exercise 3.1, 2 dice,the sum is 8
```matlab
% exercise 3.1

clc; clear; clf;

% exact computations
% by hand: (6,2),(5,3),...,(2,6)-> 5 different outcomes -> 5/36
p_hand=5/36;
% by computer:
tmp=((1:6)+(1:6)')==8;
p_comp=sum(tmp(:))/36;
assert(p_hand==p_comp);

% approximate computation
% by simulation:
N=100000;
tmp=randi(6,N,2);
sim=cumsum((tmp(:,1)+tmp(:,2))==8)./(1:N)';

% plot the results (getting a taste of the asymptotic behaviour)
plot(1:N, sim, ".",[1,N],[p_hand, p_hand]);
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
legend(["simulation", "theoretical"],"Location","northeastoutside");
title("exercise 3.1 two dice\n the sum is 8");

```


#### exercise 3.3, 2 dice,the first is larger
```matlab
% exercise 3.3

clc; clear; clf;

% exact computations
% by hand: 6->#5, 5->#4,...,2->#1  ---> 15 different outcomes -> 15/36
p_hand=15/36;
% by computer:
tmp=(1:6)-(1:6)';
p_comp=sum(tmp(:)>0)/36;
assert(p_hand==p_comp);

% approximate computation
% by simulation:
N=100000;
tmp=randi(6,N,2);
sim=cumsum(tmp(:,1)>tmp(:,2))./(1:N)';

% plot the results (getting a taste of the asymptotic behaviour)
plot(1:N, sim, ".",[1,N],[p_hand, p_hand]);
axis([1,N,0.7*p_hand, 1.3*p_hand]);
yt=(0.7:0.05:1.3)*p_hand;
yticks(yt);
text(N,p_hand,"  p="+strip(string(rats(p_hand))));
legend(["simulation", "theoretical"],"Location","northeastoutside");
title("exercise 3.2 two dice\n the first > second");

```


#### exercise 3.7, men,women,round table
```matlab
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

```


#### exercise 3.14, colored balls
```matlab
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

```


#### exercise 3.17, lottery, hit>=3
```matlab
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

```



