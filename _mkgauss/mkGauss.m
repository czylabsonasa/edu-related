function g=mkGauss(M)
   function subtract0(c,i,j)
      % subtract0(c,i,j)
      % subtract c times the i-th row from the j-th one
      % it modifies the matrix M (in place)
      % M(j,:)=M(j,:)-c*M(i,:)
      M(j,:)=M(j,:)-c*M(i,:);
   end
   function swap0(i,j)
      % swap0(c,i,j)
      % swaps the i-th and j-th row
      % it modifies the matrix M (in place)
      tmp=M(j,:);
      M(j,:)=M(i,:);
      M(i,:)=tmp;
   end

   function mul0(c,i)
      % mul0(c,i)
      % multiplies the i-th row by c
      % it modifies the matrix M (in place)
      M(i,:)=c*M(i,:);
   end


   function show0()
      disp(M);
   end

   g.subtract=@subtract0;
   g.swap=@swap0;
   g.mul=@mul0;
   g.show=@show0;
end