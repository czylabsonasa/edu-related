clf;clear;clc;

SS=33;
W=0.8;
P=0.4;
G=0.2;
GG=0.3;
NG=3;
maxit=33;

func_store;
akt=store.camel;
f=akt.f;
LO=akt.LO;
UP=akt.UP;
optval=akt.optval;

fv = @(v) f(v(1),v(2));

xx=linspace(LO,UP);
[XX,YY]=meshgrid(xx,xx);
ZZ=f(XX,YY);

pos=LO+(UP-LO)*rand(2,SS);
velo=2*rand(2,SS)-1; 

contour(XX,YY,ZZ,33);
hold on;
plot(pos(1,:),pos(2,:),"*");
drawnow;
hold off;


gg_best_val=Inf;
gg_best_pos=[Inf;Inf];

p_best_val=zeros(1,SS);
p_best_pos=pos;
for s=1:SS
   apos=pos(:,s);
   aval=fv(apos);
   p_best_val(s)=aval;
   if aval<gg_best_val
      gg_best_val=aval;
      gg_best_pos=apos;
   end
end

for it=1:maxit
   for s=1:SS
      I=datasample(1:SS,NG,Replace=false); % s-et ki kellene dobni...
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
   
   contour(XX,YY,ZZ,33);
   hold on;
   plot(pos(1,:),pos(2,:),"*");
   title(sprintf("best: %.4f opt: %.4f it: %d",gg_best_val,optval,it));
   drawnow;
   hold off;

   for s=1:SS
      apos=pos(:,s);
      aval=fv(apos);
      if aval<p_best_val(s)
         p_best_val(s)=aval;
         p_best_pos(:,s)=apos;
         if aval<gg_best_val
            gg_best_val=aval;
            gg_best_pos=apos;
         end
      end
   end
end
gg_best_pos
gg_best_val