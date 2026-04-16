clc;

rastrigin=@(x) 10*2+sum(x.*x-10*cos(pi*x));
E=@(x) rastrigin(x);

fun=@(x)x.*sin(3*x.^2)-x.*cos(x.^2)+x;
E=@(x) fun(x);
xx=linspace(-pi,pi,1000);
yy=fun(xx);
%plot(xx,fun(xx));
[optval,i]=min(yy)
optloc=xx(i)
dom=@(x) (-pi<x & x<pi);

%return


%rng(22);
x=2*pi*rand()-pi;
[x,Ex]=szh(x,E,dom);
x
Ex

function [xbest,Ebest]=szh(x,E,dom)
    Ex=E(x);
    xbest=x;
    Ebest=Ex;

    T0=1;
    T1=1e-100;
    alfa0=0.85;
    alfa1=0.99999;

    delta0=1;
    delta1=0.1;

    T=T0;
    alfa=alfa0;
    delta=delta0;

    step=0;
    while T>T1 && step<100000
        step=step+1;
        for n=1:10
          [y,Ey]=xnew(x,delta);
          dE=Ey-Ex;
          if dE<=0
              x=y;
              Ex=Ey;
              if Ex<Ebest
                xbest=x;
                Ebest=Ex;
              end
          else
              if rand()<exp(-dE/T)
                  x=y;
                  Ex=Ey;
              end
          end
        end
        T=alfa*T;
        alfa=alfa0+(T-T0)*(alfa1-alfa0)/(T1-T0);
        delta=delta0+(T-T0)*(delta1-delta0)/(T1-T0);
        
    end

    function [x,Ex]=xnew(x,delta)
      xx=x+delta*randn(1,10);
      xx=xx(dom(xx));
      EE=E(xx);
      [~,i]=min(EE);
      x=xx(:,i);
      Ex=EE(i);
    end


    fprintf("step=%d T=%.2e\n",step,T);

end