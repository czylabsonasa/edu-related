% p is given decreasing order
% look at the differences with horner.m
function y=hornervect(p,t,x)
    y=p(1)*ones(size(x));
    for i=2:length(p)
        y=y.*(x-t(i))+p(i);
    end
end