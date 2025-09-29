### simple benchmark: loop vs. vectorized
- [loop based](ver1.m)
- [vectorized](ver2.m)
- the machine: i5@6500+32Gb+ssd+linux

```matlab
>> tic; ver1; toc;

pApB =

    0.0107


pAB =

    0.0097

Elapsed time is 7.772481 seconds.
>> tic; ver2; toc;

pApB =

    0.0107


pAB =

    0.0098

Elapsed time is 1.089294 seconds.
>> 
```





