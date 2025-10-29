>> g=mkGauss([1,2,3,4;5 6 7 8;4 3 2 1])

g = 

  struct with fields:

    subtract: @mkGauss/subtract0
        swap: @mkGauss/swap0
        show: @mkGauss/show0

>> g.show()
     1     2     3     4
     5     6     7     8
     4     3     2     1

>> g.subtract(5,1,2);g.show()
     1     2     3     4
     0    -4    -8   -12
     4     3     2     1

>> g.subtract(4,1,3);g.show()
     1     2     3     4
     0    -4    -8   -12
     0    -5   -10   -15

>> g.subtract(5/4,2,3);g.show()
     1     2     3     4
     0    -4    -8   -12
     0     0     0     0

% we have inf many solutions