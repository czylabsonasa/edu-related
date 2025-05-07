pause on;

% f = @(x,y) (x-3.14).^2+(y-2.72).^2+sin(3*x+1.41)+sin(4*y-1.73);
% LO=0;UP=6;

% f=@(x,y) 100*(y-x.^2).^2+(1-x).^2;
% LO=-3;UP=3;

% f=@(x,y) 2*x.^2-1.05*x.^4+1/6*x.^6+x.*y+y.^2;
% LO=-3;UP=3;

f=@(x,y) -abs(sin(x).*cos(y).*...
   exp(abs(1-sqrt(x.^2+y.^2)/pi)));
LO=-10;UP=10;


fv = @(v) f(v(1),v(2));

xx=linspace(LO,UP,200);
[XX,YY]=meshgrid(xx,xx);
ZZ=f(XX,YY);

S=100;
pos=LO+(UP-LO)*rand(2,S);
velo=2*rand(2,S)-1; 

hold on;
contour(XX,YY,ZZ,33);
hold on;
plot(pos(1,:),pos(2,:),"*");
drawnow;


gg_best_val=Inf;
gg_best_pos=[Inf;Inf];

p_best_val=zeros(1,S);
p_best_pos=pos;
for s=1:S
   apos=pos(:,s);
   aval=fv(apos);
   p_best_val(s)=aval;
   if aval<gg_best_val
      gg_best_val=aval;
      gg_best_pos=apos;
   end
end

W=0.8;
P=0.5;
G=0.5;
GG=0.1;
N=10;
maxit=22*2*2;
for it=1:maxit
   for s=1:S
      I=datasample(1:S,N,Replace=false); % s-et ki kellene dobni...
      [~,i]=min(p_best_val(I));
      apos=pos(:,s);
      velo(:,s)=W*velo(:,s)+...
         P*rand()*(p_best_pos(:,s)-apos)+...
         G*rand()*(p_best_pos(:,I(i))-apos)+...
         GG*rand()*(gg_best_pos-apos);
      apos=apos+velo(:,s);
      apos=max([LO;LO],apos);
      apos=min([UP;UP],apos);
      pos(:,s)=apos;

   end
   
   hold off;
   contour(XX,YY,ZZ,33);
   hold on;
   plot(pos(1,:),pos(2,:),"*");
   drawnow;

   for s=1:S
      apos=pos(:,s);
      aval=fv(apos);
      if tval<p_best_val(s)
         p_best_val(s)=aval;
         p_best_pos(:,s)=apos;
         if aval<gg_best_val
            gg_best_val=aval;
            gg_best_pos=apos;
         end
      end
   end
   pause(0.01);
end
gg_best_pos
gg_best_val