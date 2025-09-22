clf;clear;

%computes a number that is >0 if there are collisions
function c=numColl(P)
   N=length(P);
   Plus=zeros(1,2*N);
   Minus=zeros(1,2*N);
   for i=1:N
      Plus(i+P(i))=Plus(i+P(i))+1;
      Minus(i-P(i)+N)=Minus(i-P(i)+N)+1;
   end
   c=sum(Plus>1)+sum(Minus>1);
end

N=10;
while true
   Q=randperm(N);
   if numColl(Q)==0
      break;
   end
end


% plotting the result
unit=[ones(3,3),zeros(3,3);zeros(3,3),ones(3,3)];
T=repmat(unit,N/2,N/2);
X=zeros(3,3);X(2,2)=6;
for i=1:N
   ii=(i-1)*3;
   jj=(Q(i)-1)*3;
   T(ii+1:ii+3,jj+1:jj+3)=max(X,T(ii+1:ii+3,jj+1:jj+3));
end

imagesc(T);