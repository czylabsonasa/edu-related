function fun=hatizsak()
   n=0;
   v=[];
   w=[];
   W=0;
   function init(data)
      n=length(data.v);
      v=data.v(:);
      w=data.w(:);
      W=data.W;
      [~,I]=sort(v./w,"descend");
      v=v(I);
      w=w(I);
    end
    
   function ilp()
      ilp_options=optimoptions("intlinprog","Display","none");
      start=tic();
      [x,fx]=intlinprog(...
         -v,...
         1:n,...
         transpose(w),W,...
         [],[],...
         zeros(n,1),ones(n,1),...
         ilp_options);
      fprintf("-----\n");
      fprintf("intlinprog opt val: %d\n", -fx);
      fprintf("%s sec\n", toc(start));
   end
    
   function naive()
      start=tic();
      opt=0;
      function trav(lev,aw,av)
         if lev>n
            if av>opt
               opt=av;
            end
            return;
         end
         if aw+w(lev)<=W
            trav(lev+1,aw+w(lev),av+v(lev));
         end
         trav(lev+1,aw,av);
      end
      trav(1,0,0);
      fprintf("-----\n");
      fprintf("naive opt val: %d\n", opt);
      fprintf("%s sec\n", toc(start));
   end

   % for some problems this has good running times
   function simple_cut()
      start=tic();
      opt=0;
      function trav(lev,aw,best_poss)
         if lev>n
            if best_poss>opt
               opt=best_poss;
            end
            return;
         end
         if aw+w(lev)<=W
             trav(lev+1,aw+w(lev),best_poss);
         end
         if best_poss-v(lev)>opt
            trav(lev+1,aw,best_poss-v(lev));
         end
        end
        trav(1,0,sum(v));
        fprintf("-----\n");
        fprintf("simple_cut opt val: %d\n", opt);
        fprintf("%s sec\n", toc(start));


   end

   
   function dantzig_cut()
      
      function bv=Dantzig(lev,aw)
         bv=0;
         while aw>0 && lev<=n
            if w(lev)<aw
               bv=bv+v(lev);
               aw=aw-w(lev);
            else
               bv=bv+(aw/w(lev))*v(lev);
               aw=0;
            end
            lev=lev+1;
         end
      end
      lastW=inf+zeros(n,1);

      start=tic();
      opt=0;
      function trav(lev,aw,av)
         if lev>n
            if av>opt
               opt=av;
            end
            return;
         end
         bv=av+Dantzig(lev,aw);
         if bv<opt
            return;
         end
         if aw+w(lev)<=W
             trav(lev+1,aw+w(lev),av+v(lev));
         end
         if bv<opt
            return;
         end
         trav(lev+1,aw,av);

      end
        trav(1,0,0);
        fprintf("-----\n");
        fprintf("dantzig_cut opt val: %d\n", opt);
        fprintf("%s sec\n", toc(start));
   end




   fun.init=@init;
   fun.reset=@reset;
   fun.ilp=@ilp;
   fun.naive=@naive;
   fun.simple_cut=@simple_cut;
   fun.dantzig_cut=@dantzig_cut;
end