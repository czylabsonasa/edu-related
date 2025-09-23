### define simple functions
- function handle
- use it for very functions, where the return value is a single object and
no loops,if branching are involved

```matlab
% simple functions in matlab
% terminology: function handle
clc;clear;

% y=x^2
fun1=@(x) x^2;

fun1(5)
fun1(10)

% fun1 does'nt work for vectors
% try it!
% fun1(1:3)

% y=x^2m "vectorized"
fun2=@(x) x.^2; %look at the dot, elementwise operation

fun2(1:3)


% functions defined this way do know about
% the variables defined outside:
A=10;
B=11;
fun6=@(x) A*x+B;

% works as expected
fun6(-1:1)
























```


