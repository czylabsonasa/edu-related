using StatsBase
using Printf

  mutable struct state
    N::Int
    x::Vector{Int}
    poz::Vector{Int}
    neg::Vector{Int}
    E::Int
    function state(x::Vector{Int})
      N=length(x)
      poz=fill(0,2N)
      neg=fill(0,2N)
      for i in 1:N
        poz[i+x[i]]+=1
        neg[i-x[i]+N]+=1
      end
      E=0
      for t in 1:2N
        (poz[t]>1) && (E+=poz[t])
        (neg[t]>1) && (E+=neg[t])
      end
      new(N,copy(x),poz,neg,E)
    end
    state(s::state)=new(s.N,copy(s.x),copy(s.poz),copy(s.neg),s.E)

  end

function nqueen_sann(N::Int)

  function deltaE(s::state,I)
    i,j=I
    xi,xj=s.x[i],s.x[j]

    s.poz[i+xi]-=1
    s.poz[j+xj]-=1
    s.neg[i+N-xi]-=1
    s.neg[j+N-xj]-=1
    s.poz[i+xj]+=1
    s.poz[j+xi]+=1
    s.neg[i+N-xj]+=1
    s.neg[j+N-xi]+=1

    E=sum(s.poz.*(s.poz.>1))+sum(s.neg.*(s.neg.>1))

    s.poz[i+xi]+=1
    s.poz[j+xj]+=1
    s.neg[i+N-xi]+=1
    s.neg[j+N-xj]+=1
    s.poz[i+xj]-=1
    s.poz[j+xi]-=1
    s.neg[i+N-xj]-=1
    s.neg[j+N-xi]-=1

    E-s.E
    
  end

  function move(s::state,I,dE)
    s.E+=dE
    i,j=I
    xi,xj=s.x[i],s.x[j]

    s.poz[i+xi]-=1
    s.poz[j+xj]-=1
    s.neg[i+N-xi]-=1
    s.neg[j+N-xj]-=1
    s.poz[i+xj]+=1
    s.poz[j+xi]+=1
    s.neg[i+N-xj]+=1
    s.neg[j+N-xi]+=1

    s.x[i],s.x[j]=s.x[j],s.x[i]
  end



  mE=0
  i=0
  while i<N
    s=state(sample(1:N,N; replace=false))
    I=sample(1:N,2;replace=false)
    dE=deltaE(s,I)
    if dE>=0
      mE+=dE
      i+=1
    end    
  end
  mE=mE/N
  T0=-mE/log(0.5)

  s=state(sample(1:N,N; replace=false))

  xbest=copy(s.x)
  Ebest=s.E


println(T0)  
  T1=1e-50
  alfa0=0.8
  alfa1=0.9999
  #alfa0=alfa1

  T=T0
  alfa=alfa0

  maxstep=10*N^2
  step=0
  while T>T1 && Ebest>0 && step<maxstep
    step=step+1
    I=sample(1:N,2;replace=false)
    dE=deltaE(s,I)
    if dE<0
      move(s,I,dE)
      if s.E<Ebest
        xbest.=s.x
        Ebest=s.E
      end
    else
      if rand()<exp(-dE/T)
        move(s,I,dE)
      end
    end

    T=alfa*T
    alfa=alfa0+(T-T0)*(alfa1-alfa0)/(T1-T0)
  end




  @printf("Ebest=%d step=%d T=%.2e\n",Ebest,step,T)

  xbest

end