### generate permutations with restrictions
- the absolute difference between neighbouring elements is <= 2
- via backtracking
- you can modify to see (get) the permutations
```matlab
clc;clear;

% N=11;
% tic;
% X=perms(1:N);
% num1=sum(sum(abs(diff(X,1,2))>=3,2)<1)
% toc;

function y=mkTrav(M)
   vis=zeros(1,M);
   x=zeros(1,M);
   num2=0;
   function Trav(lev)
      if lev>M
         num2=num2+1;
         return;
      end
      dom=max(x(lev-1)-2,1):min(x(lev-1)+2,M);
      for i1=dom
         if vis(i1)>0;continue;end
         vis(i1)=1;
         x(lev)=i1;
         Trav(lev+1);
         vis(i1)=0;
      end
   end
   for i2=1:M
      x(1)=i2;
      vis(i2)=1;
      Trav(2);
      vis(i2)=0;
   end
   y=num2;
end


tic;
for n=2:15
   num2=mkTrav(n)
end
toc;

```



