% N-th root
clc;clear;clf;

% just start to play w/ different N's
N=11;

% z=cos(alpha)+i*sin(alpha)
alpha=pi/7;

% it is the basic formula for getting each N-th root
% using vector operations
alphaK=alpha/N+(0:N-1)*2*pi/N;


% plot the points as complex numbers as separate points:
plot(exp(i*alphaK),"*")

% plot the points as complex numbers, connect them w/ line segments
% the last segment is not present
%plot(exp(i*alphaK))

% getting the last side too:
plot(exp(i*[alphaK,alphaK(1)]))

axis square
title(sprintf("N=%d",N))