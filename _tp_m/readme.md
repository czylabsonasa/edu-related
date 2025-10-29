### transportation problem with matlab
- [script version](tp_raw.m)
- [function version](tp.m)
- for creating the cost matrix see: [circshift](https://mathworks.com/help/matlab/ref/circshift.html) and [repmat](https://mathworks.com/help/matlab/ref/repmat.html)
- for getting the data see: [readmatrix](https://mathworks.com/help/matlab/ref/readmatrix.html)

#### source
```matlab
function [x,fx]=tp(C,R,F)
   % C - cost matrix
   % R - storage/factory capacity vector
   % F - warehouse/retail store capacity
   assert(sum(R)==sum(F));
   nR=length(R);
   nF=length(F);
   bas=[ones(1,nF), zeros(1,(nR-1)*nF)];
   A=[];
   for b=1:nR
       A=[A; circshift(bas,(b-1)*nF)];
   end
   A=[A; repmat(eye(nF),1,nR)];
   b=[R(:);F(:)];
   [x,fx]=linprog(C, [],[], A, b, zeros(nR*nF,1),inf*ones(nR*nF,1));
end


```



#### sample data file
```matlab
# Varga:Gyak. prog., 153.o, 2.3 példa, Vogel-Korda
# opt=530
2   4   8   3   7   20
5   0  10   4   2   30
3   6  10   5  10   40
1  10   2   6   8   50
20 20  20  20  60   140

```



#### sample session
```matlab
>> data=readmatrix("ex1.txt")

data =

     2     4     8     3     7    20
     5     0    10     4     2    30
     3     6    10     5    10    40
     1    10     2     6     8    50
    20    20    20    20    60   140

>> R=data(1:end-1,end)

R =

    20
    30
    40
    50

>> F=data(end,1:end-1)

F =

    20    20    20    20    60

>> C=data(1:end-1,1:end-1)

C =

     2     4     8     3     7
     5     0    10     4     2
     3     6    10     5    10
     1    10     2     6     8

>> [x,fx]=tp(C,R,F)

Optimal solution found.


x =

     0
     0
     0
    20
     0
    20
    10
     0
     0
     0
     0
    10
     0
     0
    30
     0
     0
    20
     0
    30


fx =

   530

```




