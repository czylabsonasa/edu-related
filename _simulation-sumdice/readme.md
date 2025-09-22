### simulation: sum of two throws is 7
- we know that it is exactly $\frac{1}{6}$.
- in the plot one can see the quality of the experimental results.

```matlab
clc;clear;

REP=2000;
%2 dice thrown, REP times, the results are the columns of X
X=randi(6,2,REP);

% for which throws do we got 7 as sum? 
X=(sum(X)==7);

% by counting the exact probability is:
theo=6/36;

% this code can be reused for plotting 
function plotSimResult(S)
   S=S(:)'; % assure that it is a row-vector
   dom=1:length(S);
   plot(dom,cumsum(S)./dom);
end


plotSimResult(X);


% w/o hold on new plot is created
hold on;
% plot a horiz. line:
plot([1,REP],[theo,theo]);
% the line is always in the middle:
ylim([theo-0.1,theo+0.1]);

% do not plot the subsequent results on the same canvas
hold off;



```


