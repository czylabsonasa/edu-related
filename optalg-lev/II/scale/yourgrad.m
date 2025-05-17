% function variant
function [w,status,iter]=yourgrad(w,F,dF)
   a0=1;
   iter=0;
   maxiter=1333;
   status="iter";
   dFw=dF(w);
   Fw=F(w);
   while 1==1
      p=-dFw;
      if norm(p)<1e-5, status="grad"; break; end
      iter=iter+1;
      if iter>maxiter, status="maxiter"; break; end
      a=fminbnd(@(x) F(w+x*p), 0,a0);
   
      w1=w+a*p;
      if norm(w1-w)/(1+norm(w1))<1e-12, status="xtol"; break; end
      Fw1=F(w1);
      if norm(Fw1-Fw)/(1+norm(Fw1))<1e-12, status="ftol"; break; end
      
      w=w1;
      Fw=Fw1;
      dFw=dF(w1);
   end
end

