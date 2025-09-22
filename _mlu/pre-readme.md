### follow the steps of the lu decomposition
- if `A=LU`, then we say that there is an `LU` decomposition for `A`. Usually it is assumed, 
that `A` is invertible. 
- `[L,U]=mlu(A)`: shows a steps of the lu decomposition of the supplied matrix. 
- stops in case of no `LU` decomposition
- the file `mprint.m` is used by the program

{{mlu.m}}


{{usage.m}}