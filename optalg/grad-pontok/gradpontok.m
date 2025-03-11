clc;

P=dlmread("pontok.csv");
x=P(:,1);
y=P(:,2);
z=P(:,3);
M=length(x);
rA=[ones(M,1),x,y];
opt=(rA'*rA)\(rA'*z);


mx=mean(P(:,1)); sx=std(P(:,1));
my=mean(P(:,2)); sy=std(P(:,2));
scalex=@(x) (x-mx)/sx;
scaley=@(y) (y-my)/sy;
x=scalex(x);
y=scaley(y);
A=[ones(M,1), x, y];
AtA=A'*A;
btb=z'*z;
Atb=A'*z;

F=@(x)(x'*AtA*x-2*x'*Atb+btb)/M;
dF=@(x) 2*(AtA*x-Atb)/M;

sopt=AtA\Atb;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [a,t]=armijo0(args) %x,f,df,p,a,q,c)
   arguments
      args.x double
      args.f function_handle
      args.df function_handle
      args.p double
      args.a double = 1
      args.qd double = 0.8
      args.qu double = 1.2
      args.c double = 0.3
   end
   x=args.x;
   f=args.f;
   df=args.df;
   p=args.p;
   a=args.a;
   qu=args.qu;
   qd=args.qd;
   c=args.c;


   t=0;
   fx=f(x);
   dfp=df(x)'*p;
   while 1==1
      t=t+1;
      if f(x+a*p)>fx+c*a*qu*dfp,break;end
      a=a*qu;
   end
   
   while 1==1
      t=t+1;
      if f(x+a*p)<=fx+c*a*dfp,break; end
      a=qd*a;
   end
end

% armijo=@(x,f,df,p,a) armijo0(x,f,df,p,a,0.8,0.8);


w=[rand();rand();rand()];
Fw=F(w);p=-dF(w);


a=1;
iter=0;
aiter=0;
maxiter=1333;
status="iter";
while 1==1

   if norm(p,1)<1e-5, status="grad"; break; end
   iter=iter+1;
   if iter>maxiter, status="maxiter"; break; end
   [a,t]=armijo0(x=w,f=F,df=dF,p=p,a=a,qd=0.8,qu=1.2,c=0.5);
   aiter=aiter+t;
   %a=fminbnd(@(x) F(w+x*p), 0,1)
   Fw;

   w1=w+a*p;
   if norm(w1-w,1)/(1+norm(w1,1))<1e-12, status="x-stalled"; break; end
   Fw1=F(w1);
   if norm(Fw1-Fw,1)/(1+norm(Fw1,1))<1e-12, status="fx-stalled"; break; end
   
   w=w1;
   Fw=Fw1;
   p=-dF(w);

end
iter,aiter,status
g=w'
gpredict=@(x) g(1)+g(2)*scalex(x(1))+g(3)*scaley(x(2));
G=opt'
Gpredict=@(x) G(1)+G(2)*x(1)+G(3)*x(2);
sG=sopt'
sGpredict=@(x) sG(1)+sG(2)*scalex(x(1))+sG(3)*scaley(x(2));
exact
epredict=@(x) exact(1)+exact(2)*x(1)+exact(3)*x(2);



