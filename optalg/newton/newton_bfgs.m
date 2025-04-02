function [history,status]=newton_bfgs(f,df,x0)
   status="";
   %f0=f(x0);
   df0=df(x0);
   history=[x0];
   % B a Hesse mátrix a formulában!!!
   % ezert itt M-el jelölöm
   M=eye(length(x0)); 

   for it=1:22*2
      % mivel ez a H-nak felel meg egyenletrendszert oldunk meg
      p=M\(-df0); % 122 oldal környéke
      a=armijo(f,df,x0,p,10,0.6,0.8);
      %a=fminbnd(@(u)f(x0+u*p),0,2);
      if norm(a*p)<1e-8, status="xtol";break;end
      x1=x0+a*p;
      history=[history,x1];
      df1=df(x1);
      if norm(df1)<1e-5, status="dftol";break;end
      % itt kiszamoljuk az uj H-t
      s=x1-x0;
      y=df1-df0;
      Ms=M*s;
      M=M-Ms*(Ms')/(s'*Ms)+y*y'/(s'*y);
      x0=x1;
      df0=df1;
   end
   if status=="",status="maxit";end
end
