function tdata=json2tsp(inst)
   jdata=jsondecode(fileread(inst));
   N=jdata.nV;
   predist=jdata.dist;
   dist=zeros(N,N);
   n=1;
   if jdata.kind=="full"
      for r=1:N
         for c=1:N
            dist(r,c)=predist(n);
            n=n+1;
         end
      end
   elseif jdata.kind=="lower"
      for r=1:N
         for c=1:r
            dist(r,c)=predist(n);
            dist(c,r)=dist(r,c);
            n=n+1;
         end
      end
   else % upper
      for r=1:N-1
         for c=r+1:N
            dist(r,c)=predist(n);
            dist(c,r)=dist(r,c);
            n=n+1;
         end
      end
   end
   tdata.N=N;
   tdata.dist=dist;
   tdata.pX=jdata.coord.p1;
   tdata.pY=jdata.coord.p2;
   tdata.opt=jdata.optval;
   tdata.comment=jdata.comment;
end
