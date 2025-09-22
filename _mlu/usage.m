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
