### randperm(n,...)
- returns the random permutation of the vector 1:n
- calling w/ two parameters: `randperm(n,k)`, it gives k random element 
from the vector 1..n. (not ordered)
- variation without repetition

```matlab
>> randperm(3)

ans =

     2     1     3

>> randperm(7)

ans =

     2     4     3     5     6     7     1

>> randperm(4,2)

ans =

     3     1

>> randperm(4,2)

ans =

     4     1

```


