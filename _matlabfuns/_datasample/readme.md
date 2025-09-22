### datasample(pop,k,...)
- similar to the randsample
- k element randomly selected from the population pop.
- repetition (replacement) is controlled by "replace" keyword what is followed 
true or false.

```matlab
>> datasample(-3:3,6)

ans =

    -3     3    -1     1    -1    -3

>> datasample(-3:3,6,"replace",false)

ans =

     1     2    -2    -1     3     0
```


