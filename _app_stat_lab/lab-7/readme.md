### lab-7

#### the labor files
- [first](lab-7-1.pdf)
- [second](lab-7-2.mlx)
- [third (questions)](lab-7-3-Q.mlx)
- [third (questions+answers)](lab-7-3-QA.mlx)

#### data
- [ustemp original](../data/ustemp.txt)
- [ustemp modified](../data/ustemp_mod.txt)
- [covid](../data/covid.csv)

#### vocabulary
- boxplot, bar
- median, quartile, IQR, extreme value, outlier
- ecdf
- mean, var, std
- load, mat-file, readtable
- corr
- tabulate
- flip



#### cdf/ecdf plots by hand
- we don't want vertical lines in function plots
- in practice just use `ecdf`

```matlab
clc;clear;close all;


function cdfplot(ax,X,pX)
   pause on;
   
   N=length(X);
   [~,I]=sort(X);
   X=X(I);
   pX=pX(I);
   pX=cumsum(pX);
   R=X(N)-X(1); % range
   pieces=zeros(N+1,4);
   pieces(1,:)=[X(1)-0.1*R,X(1),0,0];
   for i=1:N-1
      pieces(i+1,:)=[X(i),X(i+1),pX(i),pX(i)];
   end
   pieces(N+1,:)=[X(N),X(N)+0.1*R,1,1];

   hold on;
   for i=1:N+1
      p=pieces(i,:);
      if i==1||i==N+1;col="r";else;col="b";end
      plot(ax,p(1:2),p(3:4),col);
      pause(0.05);
   end
   hold off;

   pause off;
end

% expects a sample
function ecdfplot(ax,X)
   t=tabulate(X);
   X=t(:,1);
   pX=t(:,2);
   pX=pX/sum(pX);
   cdfplot(ax,X,pX);
end


%cdfplot([-3,1,4],[1,2,3]/6)
%cdfplot(1:10,ones(1,10)/10)
%S=randn(1,100);
S=exprnd(1,1,22*2);
R=max(S)-min(S);

ax1=subplot(2,1,1);
ecdf(ax1,S);
ax1.XLim=[min(S)-0.1*R,max(S)+0.1*R];
ax1.YLim=[0-0.3,1+0.3];
title(ax1,"ecdf");

ax2=subplot(2,1,2);
ax2.XLim=[min(S)-0.1*R,max(S)+0.1*R];
ax2.YLim=[0-0.3,1+0.3];
title(ax2,"cdfplot");
ecdfplot(ax2,S);

```


