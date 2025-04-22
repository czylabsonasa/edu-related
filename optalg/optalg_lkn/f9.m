% 9. feladat
clear;
clf;
close all;


fid=[48 88 150 221 247 311 359]';
fid=deg2rad(fid);
rd=[4.32 2.05 1.18 1.26 1.52 4.25 9.98]';


F=@(v,fi) v(1) ./ (1-v(2)*cos(fi));

par=lsqcurvefit(F, [1,1]', fid, rd)

% G=@(v) F(v,fid)-rd;
% par2=lsqnonlin(G,[1,1]')

f=@(fi) F(par,fi) ; % specializalas

figure(1);
polar(fid,rd,'r*');
hold on;
fi=linspace(0,2*pi);
polar(fi,f(fi),'b');
title('nem linearis');
hold off;


% vagy Gauss normal egyenlettel vagy polyfit-tel
A=[ones(size(fid)), cos(fid)];
par3=(A'*A)\(A'*(1./rd));
f=@(fi) 1./(par3(1)+par3(2)*cos(fi));

figure(2);
polar(fid,rd,'r*');
hold on;
fi=linspace(0,2*pi);
polar(fi,f(fi),'b');
title('Gauss normal egyenlettel');
hold off;



