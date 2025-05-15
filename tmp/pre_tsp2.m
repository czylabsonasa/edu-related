function Ebest=pre_tsp2(inst)
   tdata=json2tsp(inst);

   N=tdata.N;
   dist=tdata.dist;
   pX=tdata.pX;
   pY=tdata.pY;
   opt=tdata.opt;
   comment=tdata.comment;

   %norm_fact=max(dist(:));
   norm_fact=1;
   dist=dist/norm_fact;

   %initparams
   maxit=10^5;
   NL=10;
   %coolit=@(t,s) 1/s^0.7;
   coolit=@(t,s) 0.999*t;

   % discover

   % discover by a simple RW
   nRW=10000;
   max_delta=0;
   x0=randperm(N);
   Ex0=E(x0);
   for it=1:nRW
      x1=move(x0);
      Ex1=E(x1);
      delta=Ex1-Ex0;
      if delta>0
         max_delta=max(max_delta,delta);
      end
      Ex0=Ex1;
      x0=x1;
   end
   max_delta
   T=-max_delta/log(0.9)

   
   x=randperm(N);
   Ex=E(x);
   xbest=x;
   Ebest=Ex;

   
   it=1;
   while T>0 && it<maxit
      tEbest=Ebest;
      for n=1:NL
         x1=move(x);
         Ex1=E(x1);
         if Ex1<=Ex
            x=x1;
            Ex=Ex1;
            if Ex<tEbest
               tEbest=Ex;
               xbest=x;
            end
         else
            if rand()<exp((Ex1-Ex)/T)
               x=x1;
               Ex=Ex1;
            end
         end
      end
      if tEbest<Ebest
         Ebest=tEbest;
         rajz();
      end
      it=it+1;
      T=coolit(T,it);
   end

   Ebest=norm_fact*Ebest;

   
   function X=move(X)
      if rand()<0.99
         I=randi(N,1,2);
         X(I) = X([I(2), I(1)]);
      else
         while true
            I=randi(N,1,2);
            if I(1)>I(2)
               I=I([2,1]);
            end
            if I(2)-I(1)>3
               break;
            end
         end
         X([I(1),I(1)+1,I(2)-1,I(2)])=X([I(2),I(2)-1,I(1)+1,I(1)]);
      end
   end
   
   function Y=E(X)
      Y=0;
      for i=1:N-1
         Y=Y+dist(X(i),X(i+1));
      end
      Y=Y+dist(X(N),X(1));
   end

   function rajz()
      X=[pX(xbest);pX(xbest(1))];
      Y=[pY(xbest);pY(xbest(1))];
      plot(X,Y);
      tmp=norm_fact*Ebest;
      title(sprintf("%s\ngoodness: %.2f Ebest: %f\n step: %d T: %.4f",comment,opt/tmp,tmp,it,T));
      drawnow;
   end



end