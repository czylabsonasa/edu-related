clc;
N=100;
[x,hx]=szh(N);
hx
% xx=zeros(N,N);
% for i=1:N
%     xx(i,x(i))=1;
% end
% imagesc(xx)
% axis square


function [x,hx]=szh(N)
    poz=zeros(2*N,1);
    neg=zeros(2*N,1);

    x=randsample(N,N);
    hx=h(x);

    T0=1;
    T1=1e-22;
    alfa0=0.8;
    alfa1=0.9999;

    T=T0;
    alfa=alfa0;
    %update=@(T,alfa,i) 0.9999*T;
    %update=@(T,i) T0/(1+i)^4;

    

    step=0;
    while T>T1 && hx>0
        step=step+1;
        y=xnew(x);
        hy=h(y);
        dh=hy-hx;
        if dh<0
            x=y;
            hx=hy;
        else
            if rand()<exp(-dh/T)
                x=y;
                hx=hy;
            end
        end
        
        T=alfa*T;
        alfa=alfa0+(T-T0)*(alfa1-alfa0)/(T1-T0);
    end

    function x=xnew(x)
        I=randsample(N,2);
        x(I)=x([I(2);I(1)]);
        % if rand()<0.5
        %     I=randsample(N,2);
        %     x(I)=x([I(2);I(1)]);
        % end
        
    end

    function hx=h(x)
        % poz=zeros(2*N,1);
        % neg=zeros(2*N,1);
        poz(:)=0;
        neg(:)=0;
        for i=1:N
            t=i+x(i);
            poz(t)=poz(t)+1;
            t=i-x(i)+N;
            neg(t)=neg(t)+1;
        end
        %hx=sum(poz>1)+sum(neg>1);
        hx=sum(poz.*(poz>1))+sum(neg.*(neg>1));
        % hx=0;
        % for i=1:2*N
        %   hx=hx+(poz(i)>1).*poz(i);
        %   poz(i)=0;
        %   hx=hx+(neg(i)>1).*neg(i);
        %   neg(i)=0;
        % end
        
    end

    fprintf("step=%d T=%.2e\n",step,T);

end