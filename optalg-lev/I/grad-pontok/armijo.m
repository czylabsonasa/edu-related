function a=armijo(f,df,x,p,a,c1,rho)
  fx=f(x);  
  dfx=df(x);
  dfp=dfx'*p
  while f(x+a*p)>fx+a*c1*dfp
    a=a*rho;
  end
end
