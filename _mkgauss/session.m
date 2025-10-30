g=mkGauss([1,2,3,4;5 6 7 8;4 3 2 1]);
g.show()
     1     2     3     4
     5     6     7     8
     4     3     2     1

g.subtract(5,1,2);g.show()
     1     2     3     4
     0    -4    -8   -12
     4     3     2     1

g.subtract(4,1,3);g.show()
     1     2     3     4
     0    -4    -8   -12
     0    -5   -10   -15

g.subtract(5/4,2,3);g.show()
     1     2     3     4
     0    -4    -8   -12
     0     0     0     0

g.mul(-1/4,2);g.show();
     1     2     3     4
     0     1     2     3
     0     0     0     0

g.subtract(2,2,1);g.show()
     1     0    -1    -2
     0     1     2     3
     0     0     0     0

rref([1,2,3,4;5 6 7 8;4 3 2 1])

ans =

     1     0    -1    -2
     0     1     2     3
     0     0     0     0


% we have inf many solutions