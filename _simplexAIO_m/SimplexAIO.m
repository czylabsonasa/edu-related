function SimplexAIO(fname)
%
% all in one version
%
% simplex tables w/ auto computations
% usage: Simplex(fname)
% see the data.txt for the format (nothing special)
% two type of commands:
% empty (only enter): exit
% v1 v2: the basis v1 variable will be 
% swapped with the non-basis v2
%
% you should set the console font to some monospace one.
%
   %clc;
   FU=FracUtil();
   SU=StrUtil();

   tbl=SU.readtable(fname);
   nRow=size(tbl,1);
   nCol=size(tbl,2);
   VT=VecTab(nRow,nCol,2,"int64");
   setVT();
   tVT=VecTab(nRow,nCol,2,"int64");
   % dbg:
   %tVT.getStore();
   %VT.getStore();

   while 1>0
      fprintf(SU.strtable(tbl)+"\n");
      while 1>0
         loc=procResp(input("? ","s"));
         hLoc=length(loc);
         if hLoc==0
            fprintf("bye\n");
            return;
         elseif hLoc~=2
            fprintf(loc+"\n");
            continue;
         else 
            fprintf(swap(loc(1),loc(2))+"\n");
            break;
         end
      end

   end

   function loc=procResp(cmd)
      cmd=strsplit(cmd);
      cmd=cmd(cmd>"");
      hCmd=length(cmd);
      if hCmd==0
         loc=[];
      elseif hCmd~=2
         loc="error in user query";
      else
         I=find(tbl(:,1)==cmd(1));
         J=find(tbl(1,:)==cmd(2));
         if isempty(I) || isempty(J) || I<2 || J<2 || I==nRow || J==nCol
            loc="error in user query";
         else
            loc=[I;J];
         end
      end
   end

   function res=swap(I,J)
      piv=VT.get(I,J);
      if piv(1)==0
         res="error: pivot element is 0";
         return;
      end
      iPiv=FU.inv(piv);

      tmp=tbl(1,J);
      tbl(1,J)=tbl(I,1);
      tbl(I,1)=tmp;
      

      for i=2:nRow
         for j=2:nCol
            if i==I && j==J
               tVT.set(i,j,iPiv);
               tbl(i,j)=FU.str(iPiv);
            elseif i==I
               tmp=FU.mul(VT.get(i,j),iPiv);
               tVT.set(i,j,tmp);
               tbl(i,j)=FU.str(tmp);
            elseif j==J
               tmp=FU.mul(VT.get(i,j),iPiv);
               tmp(1)=-tmp(1);
               tVT.set(i,j,tmp);
               tbl(i,j)=FU.str(tmp);
            else
               tmp=FU.mul(VT.get(i,J),iPiv);
               tmp=FU.mul(tmp,VT.get(I,j));
               tmp(1)=-tmp(1);
               tmp=FU.add(tmp,VT.get(i,j));
               tVT.set(i,j,tmp);
               tbl(i,j)=FU.str(tmp);
            end
         end

      end
      VT.setStore(tVT.getStore());


      res="ok";
   end

   function setVT()
      for i=2:nRow
         for j=2:nCol   
            VT.set(i,j,FU.get(tbl(i,j)));
         end
      end
   end
   
   function setStr() %not needed
      for i=1:nRow
         for j=1:nCol   
            strTbl(i,j)=FU.str(VT.get(i,j));
         end
      end
   end


end


function FU=FracUtil()
%
% 2-element int64 (wired in) vector based fractions
% structured usage -> VecTab
%
   intLim=2^60;

   function Y=frac0(a,b)
      if b<0
         b=-b;
         a=-a;
      end
      assert(b>0, "error: division by zero");
      Y=int64([a;b]);
   end

   function f=simp0(f)
      f=frac0(f(1),f(2));
      f=idivide(f,gcd(f(1),f(2)),"fix");
   end

   function Y=rand0(L)
      assert(L>1,"L must be >1");
      Y=simp0(randi(L,2,1,int64));
      if rand()<0.5
         Y(1)=-Y(1);
      end
   end
   
   function Z=add0(X,Y)
      dZa=double(X(1))*double(Y(2))+double(Y(1))*double(X(2));
      dZb=double(X(2))*double(Y(2));
      assert(abs(dZa)<intLim && dZb<intLim,"result is close to an int64 overflow");
      Z=simp0([X(1)*Y(2) + Y(1)*X(2); X(2)*Y(2)]);
   end

   function Z=mul0(X,Y)
      dZa=double(X(1))*double(Y(1));
      dZb=double(X(2))*double(Y(2));
      assert(abs(dZa)<intLim && dZb<intLim,"result is close to an int64 overflow");
      Z=simp0([X(1)*Y(1); X(2)*Y(2)]);
   end


   function S=str0(X)
      if X(2)>1
         S=sprintf("%d/%d",X(1),X(2));
      else
         S=sprintf("%d",X(1));
      end
   end
   
   function X=get0(S)
      ab=sscanf(S,"%d/%d");
      assert(~isempty(ab), "malformed data");
      if length(ab)<2
         X=simp0([ab(1);1]);
      else
         assert(ab(2)~=0, "zero denominator")
         X=simp0(ab(:));
      end
   end

   function Y=sum0(X)
      Y=frac0(0,1);
      for x=X
         Y=add0(Y,x);
      end
   end

   function Y=prod0(X)
      Y=frac0(1,1);
      for x=X
         Y=simp0([Y(1)*x(1);Y(2)*x(2)]);
      end
   end

   function Y=inv0(X)
      assert(X(1)~=0,"error: inverse of 0");
      Y=simp0([X(2);X(1)]);
   end



   % matlab specific stuff, only "function handle"-s can be returned
   
   FU.frac=@frac0;
   FU.simp=@simp0;
   FU.rand=@rand0;
   FU.add=@add0;
   FU.mul=@mul0;
   FU.str=@str0;
   FU.get=@get0;
   FU.sum=@sum0;
   FU.prod=@prod0;
   FU.inv=@inv0;

end


function SU=StrUtil()
   function S=zeros0(nRow,nCol)
      S=repelem("",nRow,nCol);
   end

   function S=split0(s)
      S=strsplit(s," ");
      S=S(S>"");
   end

   function M=readtable0(fname)
      L=readlines(fname);
      M=[];
      nR=0;
      nC=0;
      for it=1:length(L)
         sp=split0(L(it));
         hSp=length(sp);
         if hSp>0
            assert(nR==0 || hSp==nR,"error: data file");
            nR=hSp;
            nC=nC+1;
            M=[M;sp];
         end
      end
   end
   
   function S=strtable0(M)
      nR=size(M,1);
      nC=size(M,2);
      al=max(strlength(M(:)))+4;
      M(1,1)="";
      for x=1:nR
         for y=1:nC
            M(x,y)=sprintf("%*s",al,M(x,y));
         end
      end
      S=[];
      for x=1:nR
         S=[S,strjoin(M(x,:))];
      end
      S=strjoin(S,"\n");
   end


   SU.zeros=@zeros0;
   SU.split=@split0;
   SU.readtable=@readtable0;
   SU.strtable=@strtable0;
end


function VT=VecTab(nRow,nCol,d,T)
%
% matrix of column vectors
%
   store=zeros(nRow*nCol*d,1,T);
   R=nRow*d;
   function y=get0(i,j)
      I=(i-1)*R+(j-1)*d;
      y=store(I+1:I+d);
   end
   function set0(i,j,v)
      I=(i-1)*R+(j-1)*d;
      store(I+1:I+d)=v;
   end
   function y=getStore0()
      y=store;
   end
   function setStore0(x)
      store=x;
   end

   VT.set=@set0;
   VT.get=@get0;
   VT.getStore=@getStore0;
   VT.setStore=@setStore0;

end



