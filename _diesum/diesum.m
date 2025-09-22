clc;clear;
N=10;
dp=zeros(N,N*6);
dp(1,:)=1;
for n=1:N-1
   for oldVal=1*n:6*n
      for newVal=oldVal+1:oldVal+6
         dp(n+1,newVal)=dp(n+1,newVal)+dp(n,oldVal);
      end
   end
end

for n=1:N
   fprintf("%d ",dp(n,1:6*n));
   fprintf("\n");
end