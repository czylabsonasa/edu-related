% exercise 6.1
% vectorized version
clear;

N=10^7;
% N columns = N outcomes
SIM=randi(2,10,N)-1;
% sum will sum the columns (the result will be a row vector with column sums)
S=sum(SIM);
% vectorized logical operations and sum will applied (arithmetic on boolens)
A=sum(S>0 & S<10);
B=sum(S<=1);
AB=sum(S==1);

pApB=(A/N)*(B/N)
pAB=AB/N


