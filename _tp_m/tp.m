function [x,fx]=tp(data_file)
   % [x,fx]=tp(data_file)
   % can have comments (at least in the header)
   C=readmatrix(data_file,"CommentStyle",["#"],"FileType","text");
   % C=readmatrix(data_file);
   R=C(1:end-1,end);
   F=C(end,1:end-1);
   assert(sum(R)==sum(F));
   C=C(1:end-1,1:end-1);
   [nR,nF]=size(C);

   bas=[ones(1,nF), zeros(1,(nR-1)*nF)];
   A=[];
   for b=1:nR
       A=[A; circshift(bas,(b-1)*nF)];
   end
   A=[A; repmat(eye(nF),1,nR)];
   b=[R(:);F(:)];
   % we need row-major splatting:
   C=C';C=C(:);
   [x,fx]=linprog(C, [],[], A, b, zeros(nR*nF,1),inf*ones(nR*nF,1));
   % reshape x, to see the optimal transportation:
   x=reshape(x,nF,nR)';
end

