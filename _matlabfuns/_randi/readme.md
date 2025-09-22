### rand(imax,...)
- uniform integers from 1...imax interval
- the replacement cannot be controlled: always with replacement


```matlab
>> randi()
Error using randi
Not enough input arguments.
 
>> randi(10)

ans =

    10

>> randi(10,1,5)

ans =

    10     5     9     2     5

>> randi(10,2)

ans =

    10    10
     8     7

```


