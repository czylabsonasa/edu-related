### define custom functions

- use it for "heavy" functions

```matlab
% functions in matlab
clc;clear;

% y=x^2
function y=fun1(x)
   y=x^2;
end

fun1(5)
fun1(10)

% fun1 does'nt work for vectors
% try it!
% fun1(1:3)

% y=x^2m "vectorized"
function y=fun2(x)
   y=x.^2; %look at the dot, elementwise operation
end

fun2(1:3)

% no return value, only a side-effect:
% + if branching
function fun3(x)
   if x>1
      disp("larger than 1");
   else
      disp("not larger than 1");
   end
end

fun3(0)
fun3(2)

% neither return value nor parameter
function fun4()
   x=linspace(-4*pi,4*pi);
   plot(x,sin(x));
end

fun4()


% multiple return values, different types are possible
% many simple tools are introduced
% 
function [day,month,year]=fun5()
   tmp=split(string(date),'-');
   day=str2num(tmp(1));
   month=tmp(2);
   year=str2num(tmp(3));
end

[d,m,y]=fun5()


% functions defined this way do not know about
% the variables defined outside:
A=10;
B=11;
function y=fun6(x)
   y=A*x+B;
end

% error: unrecognized variable
fun6(-1:1)

% possible solution: use function handle-s























```


