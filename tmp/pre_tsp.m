%inst="bays_29";
function Ebest=pre_tsp(inst)
   xy=dlmread(inst+".xy");
   [N,~]=size(xy);
   dist=dlmread(inst+".dist");
   norm_fact=100*max(dist(:));
   dist=dist/norm_fact;

   opt=dlmread(inst+".opt");
   

   %init
   x=randperm(N);
   Ex=E(x);
   Ebest=Ex;
   xbest=x;
   maxstep=100000;
   NL=11;
   T=10000000;
   step=1;
   while T>0 && step<maxstep
      tEbest=Ebest;
      for n=1:NL
         step=step+1;
         x1=szomszed(x);
         Ex1=E(x1);
         if Ex1<Ex
            x=x1;
            Ex=Ex1;
            if Ex<tEbest
               tEbest=Ex;
               xbest=x;
            end
         else
            if rand()<exp(-(Ex1-Ex)/T)
               x=x1;
               Ex=Ex1;
            end
         end
      end
      if tEbest<Ebest
         Ebest=tEbest;
         XY=xy(xbest,:);
         plot([XY(:,1);XY(1,1)],[XY(:,2);XY(1,2)]);
         title(sprintf("Ebest: %f step: %d T: %.4f",Ebest,step,T));
         drawnow;
      end

      T=1/(step+1)^0.7;
      %T=0.95*T;
   end
   Ebest=norm_fact*Ebest;

   %dist(1:5,1:5)
   
   function X=szomszed(X)
      I=randi(N,1,2);
      %I=datasample(1:N, 2, "Replace",false);
      X(I) = X([I(2), I(1)]);

      % r=rand();
      % if r<0.7
      %    I=randi(N-1);
      %    x([I,I+1])=x([I+1,I]);
      % elseif r<0.85
      %    I=datasample(1:N, 2, "Replace",false);
      %    x(I) = x([I(2), I(1)]);
      % else
      %    I=datasample(1:N, 3, "Replace",false);
      %    x(I) = x([I(3),I(2),I(1)]);
      % end
   end
   function Y=E(X)
      Y=0;
      for i=1:N-1
         Y=Y+dist(X(i),X(i+1));
      end
      Y=Y+dist(X(N),X(1));
   end
  
end