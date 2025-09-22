function [L,U]=mlu(A)
% 
% LU - also print the L 
% 
  U = A ; % copy - not a reference
  s = size(U) ;
  r = s(1) ;
  c = s(2) ;
  if not(r == c ) 
    mprint('A must be square',[]) ;
    return ;
  end
  L = eye(r,r) ;

  mprint('\nphase 0:\n',[L,U]) ;
  for i=1:r-1
    fprintf('\nphase %d:\n', i) ;
    if abs(U(i,i))==0
      if any(abs(U(i+1:end,i))>0)
        mprint('\n  no way w/o swap...exiting...\n',[]);
        return ;
      else
        mprint('\n  no need to eliminate\n',[]);
        continue ;
      end
    end
    p = 1.0/U(i,i) ;
    for j=(i+1):r
      fprintf('\n  sub-phase %d:\n', j) ;
      lji = p*U(j,i) ;
      L(j,i)=lji ;
      if abs(lji)>0
        U(j,:) = U(j,:) - lji*U(i,:) ;
        U(j,i)=0 ;

        mprint(sprintf('\n    subtract %s times the %d. row from the %d. row\n', strtrim(rats(lji)), i, j),...
          [L,U]) ;
      else
        mprint('\n    nothing to eliminate\n',[]);
      end
    end
  end
  % here L and U returned according to the head of the function
end