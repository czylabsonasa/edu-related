function Ebest=tsp(inst)
    data=json2tsp(inst);
    
    N=data.N;
    dist=data.dist;
    pX=data.pX;
    pY=data.pY;
    opt=data.opt
    comment=data.comment;
    norm_fact=100*max(dist(:));
    dist=dist/norm_fact;

    T=10^5;
    maxit=1000*2;
    NT=16*2*2;
    coolit=@(t,i) 0.97*t;
    nMOV=8*2;
    move=@(x) move_n(x,nMOV);

    x=randperm(N);
    Ex=E(x);
    xbest=x;
    Ebest=Ex;

    it=1;
    while T>0 && it<maxit
        israjz=false;
        for s=1:NT
            [x1,Ex1]=move(x);
            delta=Ex1-Ex;
            if delta<=0
                x=x1;
                Ex=Ex1;
                if Ex<Ebest
                    xbest=x;
                    Ebest=Ex;
                    israjz=true;
                end
            else
                if rand()<exp(-delta/T)
                    x=x1;
                    Ex=Ex1;
                end
            end
        end % NT
        if israjz 
            rajz();
        end
        it=it+1;
        T=coolit(T,it);
    end % maxit
    Ebest=Ebest*norm_fact;

    function Ex=E(x)
        Ex=0;
        for i=1:N-1
            Ex=Ex+dist(x(i),x(i+1));
        end
        Ex=Ex+dist(x(N),x(1));
    end

    function x=move_1(x)
        I=randi(N,2,1);
        x(I)=x([I(2),I(1)]);
    end

    function [xb,Exb]=move_n(x,n)
        xb=zeros(1,N);
        Exb=Inf;
        for i=1:n
            xt=move_1(x);
            Ext=E(xt);
            if Ext<Exb
                xb=xt;
                Exb=Ext;
            end
        end
    end

    function rajz()
        plot([pX(xbest);pX(xbest(1))],[pY(xbest);pY(xbest(1))]);
        title(sprintf("%s\n goodness: %.2f T: %.2f it: %d",...
            comment,norm_fact*Ebest/opt,T,it));
        drawnow;
    end

end
