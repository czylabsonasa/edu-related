function Simplex(fname)
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
   clc;
   FU=FracUtil2();
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
