clc;clf;clear;

xx=linspace(0,1,13);
yy=linspace(0,1,13)'; % paratlan, a csucs miatt.
[XX,YY]=meshgrid(xx,yy);
ZZ=zeros(size(XX));

perem=@(y) 1/2-abs(y-1/2);
%perem=@(y) 1/4-(y-1/2).^2;


ZZ(:,1)=perem(yy);
ZZ(:,end)=perem(yy); 
% a masik ket perem 0 ! 

% ZZ(1,:)=0.25*perem(xx);
% ZZ(end,:)=0.5*perem(xx); 
obj=mkobj(ZZ,xx,yy);
%obj=mkobj(ZZ,yy,xx);

P=ZZ(2:end-1,2:end-1);
[P,val]=fminunc(obj,P);

ZZ(2:end-1,2:end-1)=P;
mesh(XX,YY,ZZ)

% w/ loop
function obj=mkobj(ZZ,xx,yy)
   comp_area=@(v,w)sqrt(dot(v,v)*dot(w,w)-dot(v,w)^2);
   function y=obj0(P)
     ZZ(2:end-1,2:end-1)=P;
     y=0.0;
     for i=1:length(xx)-1
       for j=1:length(yy)-1
         A=[xx(i),yy(j),ZZ(j,i)];
         B=[xx(i),yy(j+1),ZZ(j+1,i)];
         C=[xx(i+1),yy(j+1),ZZ(j+1,i+1)];
         D=[xx(i+1),yy(j),ZZ(j,i+1)];
         y=y+comp_area(B-A,C-A);
         y=y+comp_area(C-A,D-A);
       end
     end
   end
   obj=@obj0;
end