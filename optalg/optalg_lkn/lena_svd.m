clear;clf;close all;

A=imread('lena512.pgm');

% A(1:3,1:3)

A=double(A)/255;

size(A) % 512x512

[U,S,V]=svd(A);
nS=length(S);


% a szingularis ertekek csokkenoleg vannak S-ben


perc=[100,70,50,10,5,1];
nf=length(perc);
for k=1:nf
   prc=perc(k);
   SS=S;
   for i=floor(prc/100*nS)+1:100
      SS(i,i)=0;
   end
   subplot(2,3,k);
   imshow(U*SS*V');
   title(sprintf('top %d percent',prc));
end

%diag(S)

