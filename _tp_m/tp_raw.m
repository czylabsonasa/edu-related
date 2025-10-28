clc; clear;
% R=4
% F=8
alap = [ones(1,8), zeros(1,32-8)];
A = [];
for b = 1:4
    A = [A; circshift(alap,(b-1)*8)];
end
A=[A; repmat(eye(8),1,4)]

b=[2 18 7 1 ...
    2 3 5 2 12 1 2 1]';
c=[...
8 10 9 8 5 10 9 9 ...
7 5 6 10 5 5 10 6 ...
7 6 6 9 8 10 9 7 ... 
8 7 5 9 9 7 6 10]';

[x,val]=linprog(c, [],[], A, b, zeros(32,1),inf*ones(32,1))

