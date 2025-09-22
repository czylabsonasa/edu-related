### randsample(n,k,...)
- k element randomly selected from the 1,...,n integer interval
- repetition (replacement) is controlled by the 3rd parameter (optional, default is false)
- the 4th param is the weight vector (see the usage)
- can be called with a collection instead of `n` (see the usage)

```matlab
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

```


