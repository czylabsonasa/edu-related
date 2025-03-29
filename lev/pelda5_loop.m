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
obj=mkobj(ZZ,XX,YY);

P=ZZ(2:end-1,2:end-1);
[P,val]=fminunc(obj,P);

ZZ(2:end-1,2:end-1)=P;
mesh(XX,YY,ZZ)

% w/ loop
function obj=mkobj(ZZ,XX,YY)
   comp_area=@(v,w)sqrt(dot(v,v)*dot(w,w)-dot(v,w)^2);
   [ROW,COL]=size(ZZ);
   function y=obj0(P)
     ZZ(2:end-1,2:end-1)=P;
     y=0.0;
     for r=1:ROW-1
       for c=1:COL-1
         A=[XX(r,c),YY(r,c),ZZ(r,c)];
         B=[XX(r,c+1),YY(r,c+1),ZZ(r,c+1)];
         C=[XX(r+1,c+1),YY(r+1,c+1),ZZ(r+1,c+1)];
         D=[XX(r+1,c),YY(r+1,c),ZZ(r+1,c)];
         y=y+comp_area(B-A,C-A);
         y=y+comp_area(C-A,D-A);
       end
     end
   end
   obj=@obj0;
end