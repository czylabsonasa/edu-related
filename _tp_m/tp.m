function [x,fx]=tp(C,R,F)
   % C - cost matrix
   % R - storage/factory capacity vector
   % F - warehouse/retail store capacity
   assert(sum(R)==sum(F));
   nR=length(R);
   nF=length(F);
   bas=[ones(1,nF), zeros(1,(nR-1)*nF)];
   A=[];
   for b=1:nR
       A=[A; circshift(bas,(b-1)*nF)];
   end
   A=[A; repmat(eye(nF),1,nR)];
   b=[R(:);F(:)];
   [x,fx]=linprog(C, [],[], A, b, zeros(nR*nF,1),inf*ones(nR*nF,1));
end

