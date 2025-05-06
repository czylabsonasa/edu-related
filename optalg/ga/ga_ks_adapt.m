% H,opt,fitness,recombine,instance,mutate
function ga_data=ga_ks_adapt(data_file)
   data=jsondecode(fileread(data_file));
   w=data.w(:);
   v=data.v(:);
   W=data.W(:);
   opt=data.opt;
   H=length(w);
   
   function y=fitness(x)
      y=v'*x;
   end

   function x=adjust(x)
      tW=w'*x;
      if tW>W
         I=randperm(H);
         k=1;
         while k<=H
            if x(I(k))>0
               x(I(k))=0;
               tW=tW-w(I(k));
               if tW<=W, break; end
            end
            k=k+1;
         end
      end
   end
   
   function [y,fy]=instance(N)
      y=rand(H,N)<0.5;
      fy=zeros(N);
      for n=1:N
         y(:,n)=adjust(y(:,n));
         fy(n)=fitness(y(:,n));
      end
   end

   function [y,fy]=recombine(x1,x2)
      c=randi(H);  % 2...H-1
      y1=adjust([x1(1:c);x2(c+1:H)]); f1=fitness(y1);
      y2=adjust([x2(1:c);x1(c+1:H)]); f2=fitness(y2);
      if f1>f2
         y=y1; fy=f1;
      else
         y=y2; fy=f2;
      end
   end

   function [x,fx]=mutate(x,mp)
      m=rand(H,1)<mp;
      x(m)=1-x(m);
      x=adjust(x);
      fx=fitness(x);
   end

   % H,opt,fitness,crossover,instance,mutate
   ga_data.H=H;
   ga_data.opt=opt;
   ga_data.fitness=@fitness;
   ga_data.recombine=@recombine;
   ga_data.instance=@instance;
   ga_data.mutate=@mutate;

end