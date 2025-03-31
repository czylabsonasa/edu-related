% test of hermite+hornervect (the vectorized version of horner)
% against spline w/ random data

for test=1:99
   % for two points we do not have inner points so spline
   % is a plain hermite interpolation
   numofpoints=2;
   t=sort(randsample(-20:20,numofpoints,false));
   f=randsample(-20:20,numofpoints);
   fp0=randi(10)-5;
   fp1=randi(10)-5;
   xx=linspace(min(t),max(t),33);
   yysp=spline(t,[fp0, f, fp1],xx);

   tt=t;
   mm=ones(1,length(tt));
   mm(1)=2;
   mm(end)=2;
   FF=[f(:),zeros(size(f(:)))];
   FF(1,2)=fp0;
   FF(end,2)=fp1;
   [p,t]=hermite(tt,mm,FF);
   yyher=hornervect(p,t,xx);
   fprintf("test %d. -> naverage difference in polinom values: %.9f\n",...
      test,sum(abs(yysp-yyher))/length(xx));
end