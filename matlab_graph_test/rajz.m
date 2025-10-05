clc;clear;clf;

nV=20;
M=randi(10,nV,nV);
M=M.*(M>8); M=M+M';
for i=1:nV
   M(i,i)=0;
end
M=M>0;

eList=cell(nV,1);
s=[];
t=[];
for a=1:nV-1
   for b=a+1:nV
      if M(a,b)>0
         s=[s,a];
         t=[t,b];
         eList{a}=[eList{a},b];
         eList{b}=[eList{b},a];
      end
   end
end

nE=length(s);
G=graph(s,t);
deg=degree(G);
subplot(4,1,4);
bar(deg);


subplot(4,1,1)
h=plot(G);
layout(h, 'force3',"Iterations",222)
h.NodeColor='y'
box off
axis off

v=randi(nV);
vis=zeros(nV,1);
vis(v)=1;
subplot(4,1,2);
imagesc(vis');

subplot(4,1,3);
bar(vis);


ms=zeros(nV,1);
IT=100000;
for it=1:IT
   v=datasample(eList{v},1);
   vis(v)=vis(v)+1;
   if mod(it,100)==0
      [~,idx]=sort(vis);
      ms=1:nV;
      ms(idx)=1:nV;
      subplot(4,1,1);
      h.MarkerSize=ms;
      subplot(4,1,2);
      imagesc(vis'/sum(vis));
      subplot(4,1,3);
      bar(vis/sum(vis));
      drawnow;
   end
end


