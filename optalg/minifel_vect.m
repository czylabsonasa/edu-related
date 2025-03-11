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

% precomputed 3-d arrays
XX0=XX(1:end-1,1:end-1);
YY0=YY(1:end-1,1:end-1);
Wh=zeros([size(XX)-1,3]);
Wh(:,:,1)=XX0-XX(1:end-1,2:end);
Wh(:,:,2)=YY0-YY(1:end-1,2:end);

Wd=zeros([size(XX)-1,3]);
Wd(:,:,1)=XX0-XX(2:end,2:end);
Wd(:,:,2)=YY0-YY(2:end,2:end);

Wv=zeros([size(XX)-1,3]);
Wv(:,:,1)=XX0-XX(2:end,1:end-1);
Wv(:,:,1)=YY0-YY(2:end,1:end-1);


obj=mkobj(Wh,Wd,Wv,ZZ);
%obj=mkobj(ZZ,yy,xx);

P=ZZ(2:end-1,2:end-1);
[P,val]=fminunc(obj,P);

ZZ(2:end-1,2:end-1)=P;
mesh(XX,YY,ZZ)

% vect
function obj=mkobj(Wh,Wd,Wv,ZZ)
   function y=obj0(P)
     ZZ(2:end-1,2:end-1)=P;
     Wh(:,:,3)=ZZ(1:end-1,1:end-1)-ZZ(1:end-1,2:end);
     Wd(:,:,3)=ZZ(1:end-1,1:end-1)-ZZ(2:end,2:end);
     Wv(:,:,3)=ZZ(1:end-1,1:end-1)-ZZ(2:end,1:end-1);
     % some dot() computed more than once, u may try to precompute them...
     y=sum(sqrt(dot(Wh,Wh,3)*dot(Wd,Wd,3)-dot(Wh,Wd,3)^2)+...
        sqrt(dot(Wd,Wd,3)*dot(Wv,Wv,3)-dot(Wd,Wv,3)^2),"all");
   end
   obj=@obj0;
end