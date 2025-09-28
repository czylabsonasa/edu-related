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