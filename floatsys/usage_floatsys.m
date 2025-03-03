% floatsys usage

% the file floatsys.m must be in the workning directory
% help floatsys;


% the functions in 'fs' can be accessed by a dot syntax
fs=floatsys();

% examples:

% compute the binary representation of x=100 (it is in decimal)
% it return a vector of digits, but if show=1 then a string representation
% also shown:
disp("100 in base 2:")
fs.digits(x=100, a=2);

% compute the ternary representation of x=100 (it is in decimal)
disp("100 in base 3:")
fs.digits(x=100, a=3);

% compute the first 10 digits (after the dot) of 0.321 in {a=2,kminus=-4,kplus=4,t=6}
disp("0.321: first 10 digits in base 2:")
fs.expand_dec(x=,a=2,d=10);

disp("0.321 first 10 digits in base 3:")
fs.expand_dec(x=321,a=3,d=10);


% represent x=1/7 in {a=2,kminus=-4,kplus=4,t=6}
disp("representation of 1/7 in the given system")
fs.represent(x=1/7,a=2,kminus=-3,kplus=3,t=4);

disp("printing out some important numbers for a floating point system")
fs.important_numbers(a=2,kminus=-3,kplus=3,t=4);