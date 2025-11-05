### transportation problem with matlab
- [script version](tp_raw.m)
- [function version](tp.m)
- for creating the cost matrix see: [circshift](https://mathworks.com/help/matlab/ref/circshift.html) and [repmat](https://mathworks.com/help/matlab/ref/repmat.html)
- for getting the data see: [readmatrix](https://mathworks.com/help/matlab/ref/readmatrix.html)
- [all in one](tp_aio.tgz)

#### source
```matlab
function [x,fx]=tp(data_file)
   % [x,fx]=tp(data_file)
   % can have comments (at least in the header)
   C=readmatrix(data_file,"CommentStyle",["#"],"FileType","text");
   % C=readmatrix(data_file);
   R=C(1:end-1,end);
   F=C(end,1:end-1);
   assert(sum(R)==sum(F));
   C=C(1:end-1,1:end-1);
   [nR,nF]=size(C);

   bas=[ones(1,nF), zeros(1,(nR-1)*nF)];
   A=[];
   for b=1:nR
       A=[A; circshift(bas,(b-1)*nF)];
   end
   A=[A; repmat(eye(nF),1,nR)];
   b=[R(:);F(:)];
   % we need row-major splatting:
   C=C';C=C(:);
   [x,fx]=linprog(C, [],[], A, b, zeros(nR*nF,1),inf*ones(nR*nF,1));
   % reshape x, to see the optimal transportation:
   x=reshape(x,nF,nR)';
end


```



#### sample data file
```matlab
# Varga:Gyak. prog., 153.o, 2.3 példa, Vogel-Korda
# opt=560 (according to linprog@matlab)
# but we have several branches to perform Vogel-Korda and

2   4   8   3   7   20
5   0  10   4   2   30
3   6  10   5  10   40
1  10   2   6   8   50
20 20  20  20  60   140

```



#### sample session
```matlab
>> [x,fx]=tp("ex1.txt")

Optimal solution found.


x =

     0     0     0     0    20
     0     0     0     0    30
     0    20     0    20     0
    20     0    20     0    10


fx =

   560

>> help tp
  [x,fx]=tp(data_file)

```




