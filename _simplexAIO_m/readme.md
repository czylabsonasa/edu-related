### simplex table computations
- **all in one version**

#### sample data file
```matlab
   _      x1       x2       x3       b
   x4     1/2       1      3/5       2
   x5       0       2     -4/5       1
   x6     3/7      -2        6       2
   z-c      1      -5       -3       0

```



#### sample session
```matlab
>> SimplexAIO("data.txt")
               x1       x2       x3        b
      x4      1/2        1      3/5        2
      x5        0        2     -4/5        1
      x6      3/7       -2        6        2
     z-c        1       -5       -3        0
? x5 x2
ok
               x1       x5       x3        b
      x4      1/2     -1/2        1      3/2
      x2        0      1/2     -2/5      1/2
      x6      3/7        1     26/5        3
     z-c        1      5/2       -5      5/2
? x6 x3
ok
                     x1          x5          x6           b
         x4       38/91       -9/13       -5/26       12/13
         x2        3/91       15/26        1/13       19/26
         x3      15/182        5/26        5/26       15/26
        z-c     257/182       45/13       25/26       70/13
? 
bye
>> 
```




