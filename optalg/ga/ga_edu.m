% ga all in one

function ga_edu()
   [obj,adjust,n,opt]=mkobj()
   fprintf("optimum==%d\n",opt);

   MUT=0.05; % ............. mutation
   SEL=3; % .................. tournament par
   NGEN=333; % ..............num of generations
   NPOP=100; % ...............size of the population
   H=n; % .................the number of genes in a chromosome
   ELIT=0.1; % ................the best ELIT proportion is always survive
   GE=Inf; % a known optimum or inf or some meaningfull/acceptable value (GE=good enough)
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
      [~,idx]=sort(fit,"descend");
      
      n=1;
      if ELIT>0
         while n<=floor(ELIT*NPOP)
            pop_next(:,n)=pop(:,idx(n));
            fit_next(n)=fit(idx(n));
            n=n+1;
         end
      end

      while n<=NPOP
         p1=select();
         p2=select();
         crossover(n,p1,p2);
         mutate(n);
         pop_next(:,n)=adjust(pop_next(:,n));
         fit_next(n)=obj(pop_next(:,n));
         n=n+1;
      end
      
      fitbest_old=fit(idx(1));
      pop=pop_next;
      fit=fit_next;
      fitbest=max(fit);
      if(fitbest<=fitbest_old)
         idle=idle+1;
      else
         idle=0;
      end

      fprintf("gen: %d   best: %d   mean: %.2f    std: %.2f\n", ngen, fitbest, mean(fit), std(fit));
      if(fitbest>=GE),break;end
      if(idle>MAXIDLE),break;end
      ngen=ngen+1;
  end

  % selection
   function i = select()
      [~,i]=max(fit(randi(NPOP, 1, SEL)));
   end

  % offspring creation
   function crossover(n, p1, p2)
      p1 = pop(:,p1);
      p2 = pop(:,p2);
      loc = randi(H);
      c1 = [p1(1:loc); p2(loc+1:end)];
      c2 = [p2(1:loc); p1(loc+1:end)];
      fc1 = obj(c1);
      fc2 = obj(c2);
      if fc1 > fc2
         pop_next(:,n)=c1;
         fit_next(n)=fc1;
      else
         pop_next(:,n)=c2;
         fit_next(n)=fc2;
      end
   end

  % the mutation
   function mutate(n)
      x=pop_next(:,n);
      for h=1:H
         if rand()<MUT
            x(h)=1-x(h);
         end
      end
      pop_next(:,n)=x;
      %fit_next(n)=obj(x);
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
         %y=(v'*x);
      end

      function x=adjust0(x)
         % tW=w'*x;
         % i=1;
         % while tW>W
         %    if x(i)>0
         %       tW=tW-w(i);
         %       x(i)=0;
         %    end
         %    i=i+1;
         % end
      end

      adjust=@adjust0;
      obj=@obj0;
   end


end % of ga
