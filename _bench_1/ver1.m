% exercise 6.1
% the version on the slide (corrected)
clear;

N=10^7;
A=0;
B=0;
AB=0;
for i=1:N
   sim=randi(2,1,10)-1;
   s=sum(sim);
   if s>0 && s<10
      A=A+1;
   end
   if s<=1
      B=B+1;
   end
   if s==1
      AB=AB+1;
   end
end
pApB=(A/N)*(B/N)
pAB=AB/N