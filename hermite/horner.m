% p is given decreasing order
function y=horner(p,t,x)
    y=p(1);
    for i=2:length(p)
        y=y*(x-t(i))+p(i);
    end
end