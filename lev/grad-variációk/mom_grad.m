function history=mom_grad(L,dL,w0,mom)
    maxstep=100;
    tol=1e-5;
    a=0.04;
    v=zeros(size(w0));
    w=w0;
    history=[w];
    Lw=L(w);
    dLw=dL(w);
    for step=1:maxstep
        if norm(dLw)<tol, break; end
        
        v=mom*v-a*dLw;
        w1=w+v;
        
        dLw1=dL(w1);
        Lw1=L(w1);
        if norm(dLw-dLw1)<tol, break; end
        if norm(Lw-Lw1)<tol, break; end
        w=w1;
        Lw=Lw1;
        dLw=dLw1;
        history=[history,w];
    end
end
