clc;clear;clf;

% 
% by hand approach: we know the cdf everything can be computed
% at least by calling appropriate functions, here: normcdf


% only "by-hand" computations, but w/o standardization

% below: P(X<-50)=F(-50):
below=normcdf(-50,20,50)
% above: P(X>50)=1-P(X<=50)=1-P(X<50)=1-F(50):
above=1-normcdf(50,20,50)
% above+inside+below=Omega:
%
inside=1-(above+below)
