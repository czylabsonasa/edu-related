% kell:
% w,F,dF,Fw,dFw

a0=1;
iter=0;
aiter=0;
maxiter=1333;
status="iter";
while 1==1
   if norm(dFw,1)<1e-5, status="grad"; break; end
   iter=iter+1;
   if iter>maxiter, status="maxiter"; break; end
   [a,t]=armijo(x=w,f=F,df=dF,p=-dFw,a=a0,rho=0.8,c=0.5);
   aiter=aiter+t;

   w1=w+a*(-dFw);
   if norm(w1-w,1)/(1+norm(w1,1))<1e-12, status="x-stalled"; break; end
   Fw1=F(w1);
   if norm(Fw1-Fw,1)/(1+norm(Fw1,1))<1e-12, status="fx-stalled"; break; end
   
   w=w1;
   Fw=Fw1;
   dFw=dF(w);

end


function [a,t]=armijo(args)
   arguments
      args.x double
      args.f function_handle
      args.df function_handle
      args.p double
      args.a double = 1
      args.rho double = 0.8
      args.ohr double = 1.2
      args.c double = 0.3
   end
   x=args.x;
   f=args.f;
   df=args.df;
   p=args.p;
   a=args.a;
   ohr=args.ohr;
   rho=args.rho;
   c=args.c;


   t=0;
   fx=f(x);
   dfp=df(x)'*p;
   % unofficial: elongate the step
   % while 1==1
   %    t=t+1;
   %    if f(x+a*p)>fx+c*a*ohr*dfp,break;end
   %    a=a*ohr;
   % end
   
   while 1==1
      t=t+1;
      if f(x+a*p)<=fx+c*a*dfp,break; end
      a=rho*a;
   end
end
