function [history,status]=newton_sima(f,df,H,x0)
   
   status="";
   f0=f(x0);
   H0=H(x0);
   df0=df(x0);
   history=[x0];

   for it=1:33
      p=H0\(-df0);
      if norm(p)<1e-8, status="xtol";break;end
      x0=x0+p;
      history=[history,x0];
      df0=df(x0);
      if norm(df0)<1e-5, status="dftol";break;end
      H0=H(x0);
   end
   if status=="",status="maxit";end
end
