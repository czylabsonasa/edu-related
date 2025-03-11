clc;clf;clear;

xx=linspace(0,1,15);
yy=linspace(0,1,15)'; % paratlan, a csucs miatt.
[XX,YY]=meshgrid(xx,yy);
ZZ=zeros(size(XX));

perem=@(y) 1/2-abs(y-1/2);
%perem=@(y) 1/4-(y-1/2).^2;


ZZ(:,1)=perem(xx);
ZZ(:,end)=perem(xx); 
% a masik ket perem 0 ! 

obj=@(P)preobj(P,ZZ,yy,xx);

P=ZZ(2:end-1,2:end-1);
[P,val]=fminunc(obj,P);

ZZ(2:end-1,2:end-1)=P;
mesh(XX,YY,ZZ)

function val=preobj(P,ZZ,yy,xx)
  ZZ(2:end-1,2:end-1)=P;
  val=0.0;
  for i=1:length(xx)-1
    for j=1:length(yy)-1
      A=[xx(i),yy(j),ZZ(j,i)];
      B=[xx(i),yy(j+1),ZZ(j+1,i)];
      C=[xx(i+1),yy(j+1),ZZ(j+1,i+1)];
      D=[xx(i+1),yy(j),ZZ(j,i+1)];
      val=val+comp_area(B-A,C-A);
      val=val+comp_area(C-A,D-A);      
    end
  end
end

function a=comp_area(v,w)
  a=sqrt(dot(v,v)*dot(w,w)-dot(v,w)^2);
end
