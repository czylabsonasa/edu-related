function FU=FracUtil2()
%
% 2-element int64 (wired in) vector based fractions
% structured usage -> VecTab
%
   intLim=2^60;

   function Y=frac0(a,b)
      if b<0
         b=-b;
         a=-a;
      end
      assert(b>0, "error: division by zero");
      Y=int64([a;b]);
   end

   function f=simp0(f)
      f=frac0(f(1),f(2));
      f=idivide(f,gcd(f(1),f(2)),"fix");
   end

   function Y=rand0(L)
      assert(L>1,"L must be >1");
      Y=simp0(randi(L,2,1,int64));
      if rand()<0.5
         Y(1)=-Y(1);
      end
   end
   
   function Z=add0(X,Y)
      dZa=double(X(1))*double(Y(2))+double(Y(1))*double(X(2));
      dZb=double(X(2))*double(Y(2));
      assert(abs(dZa)<intLim && dZb<intLim,"result is close to an int64 overflow");
      Z=simp0([X(1)*Y(2) + Y(1)*X(2); X(2)*Y(2)]);
   end

   function Z=mul0(X,Y)
      dZa=double(X(1))*double(Y(1));
      dZb=double(X(2))*double(Y(2));
      assert(abs(dZa)<intLim && dZb<intLim,"result is close to an int64 overflow");
      Z=simp0([X(1)*Y(1); X(2)*Y(2)]);
   end


   function S=str0(X)
      if X(2)>1
         S=sprintf("%d/%d",X(1),X(2));
      else
         S=sprintf("%d",X(1));
      end
   end
   
   function X=get0(S)
      ab=sscanf(S,"%d/%d");
      assert(~isempty(ab), "malformed data");
      if length(ab)<2
         X=simp0([ab(1);1]);
      else
         assert(ab(2)~=0, "zero denominator")
         X=simp0(ab(:));
      end
   end

   function Y=sum0(X)
      Y=frac0(0,1);
      for x=X
         Y=add0(Y,x);
      end
   end

   function Y=prod0(X)
      Y=frac0(1,1);
      for x=X
         Y=simp0([Y(1)*x(1);Y(2)*x(2)]);
      end
   end

   function Y=inv0(X)
      assert(X(1)~=0,"error: inverse of 0");
      Y=simp0([X(2);X(1)]);
   end



   % matlab specific stuff, only "function handle"-s can be returned
   
   FU.frac=@frac0;
   FU.simp=@simp0;
   FU.rand=@rand0;
   FU.add=@add0;
   FU.mul=@mul0;
   FU.str=@str0;
   FU.get=@get0;
   FU.sum=@sum0;
   FU.prod=@prod0;
   FU.inv=@inv0;

end