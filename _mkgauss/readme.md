### gaussian elimination steps
- elimination with user supplied steps 

#### source
```matlab
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
      % swap the i-th and j-th row
      % it modifies the matrix M (in place)
      tmp=M(j,:);
      M(j,:)=M(i,:);
      M(i,:)=tmp;
   end

   function show0()
      disp(M);
   end

   g.subtract=@subtract0;
   g.swap=@swap0;
   g.show=@show0;
end
```



#### sample session
```matlab
>> g=mkGauss([1,2,3,4;5 6 7 8;4 3 2 1])

g = 

  struct with fields:

    subtract: @mkGauss/subtract0
        swap: @mkGauss/swap0
        show: @mkGauss/show0

>> g.show()
     1     2     3     4
     5     6     7     8
     4     3     2     1

>> g.subtract(5,1,2);g.show()
     1     2     3     4
     0    -4    -8   -12
     4     3     2     1

>> g.subtract(4,1,3);g.show()
     1     2     3     4
     0    -4    -8   -12
     0    -5   -10   -15

>> g.subtract(5/4,2,3);g.show()
     1     2     3     4
     0    -4    -8   -12
     0     0     0     0

% we have inf many solutions
```




