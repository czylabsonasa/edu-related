%
% hermite polinomial computation
%
% expects:
%    tt: support points
%    mm: the multiplicities
%    FF: the derivatives, the r-th row consist of the 0-th,1-st, etc
%    derivatives of the r-th support point
% returns:
%    p: the coefficients
%    t: the support points in the appropriate order
%
function [p,t]=hermite(tt,mm,FF)
   t2row=repelem(1:length(tt),mm);
   t=repelem(tt,mm);
   R=sum(mm);
   F=zeros(R,R);
    
   % F will be filled in columnwise
   F(:,1)=repelem(FF(:,1),mm);

   for j=2:R
       for i=1:R-j+1
           if not(t(i)==t(i+j-1))
               F(i,j)=(F(i,j-1)-F(i+1,j-1))/(t(i)-t(i+j-1));
           else
               r=t2row(i);
               F(i,j)=FF(r,j)/factorial(j-1);
           end
       end
   end
   % debug:
   % [t(:),F]
   p=F(1,:);
   p=p(R:-1:1);
   t=t(R:-1:1);
end
