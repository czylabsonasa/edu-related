clc;clear;clf;
x=linspace(-1,1);
y=x.^2;

hold on;
z=x+i*y;
A=linspace(0,2*pi,9);
for a=A
   plot(exp(a*i)*z,"b");
end

z=x+(2-y)*i;
for a=A
   plot(exp(a*i)*z,"b");
end


title("mandala")
axis square