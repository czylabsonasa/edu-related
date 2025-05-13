% sim_ann0 - all in one

N = 500;
x0 = randperm(N);

E0 = obj(x0);

Ebest = E0;
xbest = x0;
T0 = 100;
Tinf = 1e-33;
Einf = 0;

T = T0;
tlevel = 1;
while tlevel<100000 && T>Tinf && Ebest >  Einf
  x1 = szomszed(x0);
  E1 = obj(x1);
  if E1<=E0
    if E1<Ebest
      Ebest = E1;
      xbest = x1;
    end
    x0 = x1;
    E0 = E1;
  else
    if rand()<1 / exp( (E1-E0)/T )
      x0 = x1;
      E0 = E1;
    end
  end
  
  tlevel=tlevel+1;
  T = T0/tlevel;
  % T = 0.9 * T;
end

result.T=T;
result.tlevel = tlevel;
result.Ebest = Ebest;
result.xbest = xbest;
result
m = zeros(N,N);
for i=1:N
    m(i, xbest(i)) = 1; 
end
imagesc(m);




function Ex = obj(x)
    N = length(x);
    plusz = zeros(2*N,1);
    minusz = zeros(2*N,1);
    for r=1:N
        c = x(r);
        minusz(r-c+N) = minusz(r-c+N) + 1;
        plusz(r+c) = plusz(r+c) + 1;
    end
    Ex = sum(minusz(minusz>1)) + sum(plusz(plusz>1));
end

function x = szomszed(x)
    N = length(x);
    I = datasample(1:N, 2, "Replace",false);
    x(I) = x([I(2), I(1)]);
end
