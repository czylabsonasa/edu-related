% ga0 all in one

function ga_01_edu()
   [obj,n,opt]=mkobj()
   fprintf("optimum==%d\n",opt);

   MUT=0.05; % ............. mutation
   K=3; % .................. tournament par
   NGEN=333; % ..............num of generations
   NPOP=100; % ...............size of the population
   H=n; % .................the number of genes in a chromosome
   ELIT=0.1; % ................the best ELIT proportion is always survive
   fitINF=Inf; % a known optimum or inf or some meaningfull/acceptable value
   MAXIDLE=20;

   % the population
   pop=rand(H,NPOP)<0.5;
   pop_next=zeros(H,NPOP);

   % the individual fitnesses
   fit=zeros(1,NPOP);
   fit_next=zeros(1,NPOP);

   % init fit
   for n = 1:NPOP
      pop(:,n)=adjust(pop(:,n));
      fit(n)=obj(pop(:,n));
   end

   % the main loop
   idle=0;
   ngen=1;
   while ngen<=NGEN
      fprintf("gen: %d   best: %d   mean: %.2f    std: %.2f\n", ngen, fitbest, mean(fit), std(fit));
      if(fitbest>=fitINF),break;end
      if(idle>MAXIDLE),break;end
      ngen=ngen+1;
  end

  % selection
   function i = select()
   end

  % offspring creation
   function crossover(n, p1, p2)
   end

  % the mutation
   function mutate(n)
   end


   % the (problem specific) fitness
   % function y=obj(x)
   %    y=sum(x);
   % end

   % function y=obj(x)
   %    W=100;
   %    % w=[18,42,88,3];
   %    % v=[114,136,192,223];
   %    % 473
   %    w=[27,2,41,1,25,1,34,3,50,12];
   %    v=[38,86,112,0,66,97,195,85,42,223];
   %    % 798

   %    y=(v*x)*(w*x<=W);
   % end

   function [obj,adjust,n,opt]=mkobj()
      data=jsondecode(fileread("ks2.json"));
      w=data.w(:);
      v=data.v(:);
      W=data.W;
      opt=data.opt;
      n=length(v);   
      
      function y=obj0(x)
         y=(v'*x)*(w'*x<=W);
      end

      obj=@obj0;
   end


end % of ga
