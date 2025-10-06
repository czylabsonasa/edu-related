clc;clear;clf;

% is it a cdf?
% by hand approach: check the extrem locations: limits + connection points 
% in case of piecewise defined functions

% by-hand approach
% a) (x-1)/(x+1) if x>=1/2, otherwise 0
% not a cdf: it negative at 1/2

% practical approach
figure(1);
xx=linspace(1/2,5);
plot([-1,1/2],[0,0],"b",xx,(xx-1)./(xx+1),"b",[-1,5],[1,1],"r");
axis padded;



% by-hand approach
% a) (x-1)/(x+1) if x>=1, otherwise 0
% it is cdf

% practical approach
figure(2);
xx=linspace(1,5);
plot([-1,1],[0,0],"b",xx,(xx-1)./(xx+1),"b",[-1,5],[1,1],"r");
axis padded;
