>> randsample(5,4)

ans =

     1
     3
     5
     2

>> randsample(5,4,true)

ans =

     1
     5
     5
     3

>> randsample([10,100,1000,10000],2)

ans =

    10   100

>> randsample([10,100,1000,10000],2,true,[1,1,1,10])

ans =

       10000       10000

>> randsample([10,100,1000,10000],2,true,[1,1,1,10])

ans =

       10000        1000
