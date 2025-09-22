### follow the steps of the lu decomposition
- if `A=LU`, then we say that there is an `LU` decomposition for `A`. Usually it is assumed, 
that `A` is invertible. 
- `[L,U]=mlu(A)`: shows a steps of the lu decomposition of the supplied matrix. 
- stops in case of no `LU` decomposition
- the file `mprint.m` is used by the program

```matlab
function [L,U]=mlu(A)
% 
% LU - also print the L 
% 
  U = A ; % copy - not a reference
  s = size(U) ;
  r = s(1) ;
  c = s(2) ;
  if not(r == c ) 
    mprint('A must be square',[]) ;
    return ;
  end
  L = eye(r,r) ;

  mprint('\nphase 0:\n',[L,U]) ;
  for i=1:r-1
    fprintf('\nphase %d:\n', i) ;
    if abs(U(i,i))==0
      if any(abs(U(i+1:end,i))>0)
        mprint('\n  no way w/o swap...exiting...\n',[]);
        return ;
      else
        mprint('\n  no need to eliminate\n',[]);
        continue ;
      end
    end
    p = 1.0/U(i,i) ;
    for j=(i+1):r
      fprintf('\n  sub-phase %d:\n', j) ;
      lji = p*U(j,i) ;
      L(j,i)=lji ;
      if abs(lji)>0
        U(j,:) = U(j,:) - lji*U(i,:) ;
        U(j,i)=0 ;

        mprint(sprintf('\n    subtract %s times the %d. row from the %d. row\n', strtrim(rats(lji)), i, j),...
          [L,U]) ;
      else
        mprint('\n    nothing to eliminate\n',[]);
      end
    end
  end
  % here L and U returned according to the head of the function
end
```



```matlab
>> A=[1 2 3;3 1 2;2 1 3];
>> [L,U]=mlu(A)

phase 0:

  1  0  0  1  2  3
  0  1  0  3  1  2
  0  0  1  2  1  3

press a key to continue


phase 1:

  sub-phase 2:

    subtract 3 times the 1. row from the 2. row

   1   0   0   1   2   3
   3   1   0   0  -5  -7
   0   0   1   2   1   3

press a key to continue


  sub-phase 3:

    subtract 2 times the 1. row from the 3. row

   1   0   0   1   2   3
   3   1   0   0  -5  -7
   2   0   1   0  -3  -3

press a key to continue


phase 2:

  sub-phase 3:

    subtract 3/5 times the 2. row from the 3. row

    1    0    0    1    2    3
    3    1    0    0   -5   -7
    2  3/5    1    0    0  6/5

press a key to continue


L =

    1.0000         0         0
    3.0000    1.0000         0
    2.0000    0.6000    1.0000


U =

    1.0000    2.0000    3.0000
         0   -5.0000   -7.0000
         0         0    1.2000

```

