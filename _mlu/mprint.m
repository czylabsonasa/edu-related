function mprint(s,A)
  % clc;
  
  fprintf(s) ;

  s = size(A) ;
  if s(1)>0
    r = s(1) ;
    c = s(2) ;
    C=cell(r,c) ;
    for i=1:r
      for j=1:c
        C{i,j}=strtrim(rats(A(i,j))) ;
      end
    end
    fprintf('\n') ;
    CC=pad(C,'left') ;
    for i=1:r
      for j=1:c
        fprintf('  %s',CC{i,j}) ;
      end
      fprintf('\n') ;
    end
  end
  
  fprintf('\npress a key to continue\n\n') ;
  pause ;
end