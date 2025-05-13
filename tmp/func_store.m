himmelblau.f=@(x,y) (x.^2+y-1).^2+(x+y.^2-7).^2;
himmelblau.LO=-5;
himmelblau.UP=5;
himmelblau.optval=0;
store.himmelblau=himmelblau;


matyas.f=@(x,y) 0.26*(x.^2+y.^2)-0.48*x.*y;
matyas.LO=-10;
matyas.UP=10;
matyas.optval=0;
store.matyas=matyas;

rosenbrock.f=@(x,y) 100*(y-x.^2).^2+(1-x).^2;
rosenbrock.LO=-3;
rosenbrock.UP=3;
rosenbrock.optval=0;
store.rosenbrock=rosenbrock;


holder.f=@(x,y) -abs(sin(x).*cos(y).*exp(abs(1-sqrt(x.^2+y.^2)/pi)));
holder.LO=-10;
holder.UP=10;
holder.optval=-19.2085;
store.holder=holder;

% schaffer2.f=@(x,y) 0.5+(sin(x.^2-y.^2).^2-0.5)/(1+0.001*(x.^2+y.^2)).^2;
% schaffer2.LO=-10;
% schaffer2.UP=10;
% schaffer2.optval=0;
% store.schaffer2=schaffer2;

camel.f=@(x,y) 2*x.^2-1.05*x.^4+x.^6/6+x.*y+y.^2;
camel.LO=-5;
camel.UP=5;
camel.optval=0;
store.camel=camel;