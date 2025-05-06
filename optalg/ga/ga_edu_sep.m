% ga all in one
% separate the problem and the method

function [x,fx,fpath,fmeanpath,fstdpath]=ga_edu_sep(ga_data)
   H=ga_data.H;
   fitness=ga_data.fitness;
   recombine=ga_data.recombine;
   instance=ga_data.instance;
   mutate=ga_data.mutate;


   NPOP=100; % ...............size of the population
   NGEN=100; % ..............num of generations

   ELITE=0.10; % ................the best ELIT proportion is always survive
   NELITE=floor(ELITE*NPOP);
   REC=0.80; % the proportion of recombined children
   NREC=floor(REC*NPOP);
   MUT=1/H; % ............. mutation probability (not the number of...)

   SEL=5; % .................. tournament par
   if isfield(ga_data,"opt")
      GE=ga_data.opt;
   else
      GE=Inf;
   end
   MAXIDLE=Inf;


   fpath=zeros(NGEN,1);
   fmeanpath=zeros(NGEN,1);
   fstdpath=zeros(NGEN,1);
     
   % the population
   [pop,fit]=instance(NPOP);
   pop_next=zeros(size(pop));
   fit_next=zeros(NPOP,1);

   % the main loop
   idle=0;
   ngen=1;
   while ngen<=NGEN
      [~,idx]=sort(fit,"descend");
      fitbest=fit(idx(1));      
      ifitbest=idx(1);
      
      n=1;
      while n<=NELITE
         pop_next(:,n)=pop(:,idx(n));
         fit_next(n)=fit(idx(n));
         n=n+1;
      end
      
      fitbest_next=fitbest;
      ifitbest_next=idx(1);
      while n<=NELITE+NREC
         [c,fc]=recombine(pop(:,select()),pop(:,select()));
         pop_next(:,n)=c;
         fit_next(n)=fc;
         if fc>fitbest_next
            fitbest_next=fc;
            ifitbest_next=n;
         end

         n=n+1;
      end

      while n<=NPOP
         [c,~]=recombine(pop(:,select()),pop(:,select()));
         [c,fc]=mutate(c,MUT);
         pop_next(:,n)=c;
         fit_next(n)=fc;
         if fc>fitbest_next
            fitbest_next=fc;
            ifitbest_next=n;
         end

         n=n+1;
      end
      
      % ez csak kivalaszt es mutal es berak a next-be
      % while n<=NPOP
      %    [p,fp]=mutate(pop(:,select()),MUT);
      %    pop_next(:,n)=p;
      %    fit_next(n)=fp;
      %    if fp>fitbest_next
      %       fitbest_next=fp;
      %       ifitbest_next=n;
      %    end
      %    n=n+1;
      % end

      if(fitbest_next<=fitbest)
         idle=idle+1;
      else
         idle=0;
      end
      
      
      pop=pop_next;
      fit=fit_next;
      fitbest=fitbest_next;
      ifitbest=ifitbest_next;

      fpath(ngen)=fitbest;
      fmeanpath(ngen)=mean(fit);
      fstdpath(ngen)=std(fit);

      fprintf("gen: %d   best: %d   mean: %.2f    std: %.2f\n", ngen, fitbest, fmeanpath(ngen), fstdpath(ngen));
      if(fitbest>=GE),break;end
      if(idle>MAXIDLE),break;end
      ngen=ngen+1;
   end
   
   fprintf("H=%d optimum=%d goodness=%.6f%s\n",H,GE,fitbest/GE*100," %");

   % selection
   function i = select()
      [~,i]=max(fit(randi(NPOP, 1, SEL)));
   end


   fx=fitbest;
   x=pop(:,ifitbest);

end % of ga
