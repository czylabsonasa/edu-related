% rosebrock 2-variable
% returns a struct, whose fields are:
% f separate variables (for plotting)
% fV vector var
% dfV gradient vector var
% d2fV Hesse vector var
function ret=rosenbrock_2var()
  f = @(x,y) 100*(y-x.^2).^2 + (1-x).^2 ;
  fV = @(v) f(v(1),v(2)) ;

  dfx = @(x,y) -400*x.*(y-x.^2) + 2*(x-1) ; 
  dfy = @(x,y) 200*(y-x.^2) ;

  dfV =@(v) [dfx(v(1),v(2)) ; dfy(v(1),v(2)) ] ;
  d2fV = @(v) [ 1200*v(1)^2-400*v(2)+2, -400*v(1) ; -400*v(1), 200] ;

  ret.f=f ;
  ret.fV=fV ;
  ret.dfV=dfV ;
  ret.d2fV=d2fV ;
end