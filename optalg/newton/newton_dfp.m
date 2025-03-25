function [history,status]=newton_dfp(f,df,x0)
   status="";
   f0=f(x0);
   df0=df(x0);
   history=[x0];
   B=eye(length(x0));

   for it=1:33
      p=B\(-df0); % vagy p=H*(-df0), 122 oldal környéke
      a=armijo(f,df,p,x0,p,1,0.8,0.8);
      if norm(a*p)<1e-8, status="xtol";break;end
      x1=x0+a*p;
      history=[history,x0];
      df1=df(x1);
      if norm(df1)<1e-5, status="dftol";break;end
      % itt kiszamoljuk az uj B-t...vagy H-t
   end
   if status=="",status="maxit";end
end
