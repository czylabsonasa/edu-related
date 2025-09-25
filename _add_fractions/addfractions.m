function addfractions()
   clc;
   fprintf("\nyour answer should be in the form of a/b (w/o any space) or a\n");
   fprintf("where a is an integer and b is a positive integer\n");
   fprintf("you can quit by giving an empty answer, that is by hitting enter (↵)\n\n");
   input("hit ↵ to start");

   eTime=tic();
   numOk=0;
   numAll=0;
   L=10;
   while 1>0
      clc;
      % two random fractions generated
      a1=randi(L);
      b1=randi(L)+2;
      a2=randi(L);
      b2=randi(L)+2;
      
      % random signs
      sg1=2*(randi(2)-1)-1;
      sg2=2*(randi(2)-1)-1;
      %fprintf("dbg: %d %d\n",sg1,sg2);
      if sg1<0
         s1="-"; 
      else 
         s1=""; 
      end
      if sg2<0
         op="-"; 
      else 
         op="+"; 
      end
      
      % prompt
      pr=sprintf("what is\n   %s%d/%d %s %d/%d \n?  ",s1,a1,b1,op,a2,b2);
      uResp=strip(input(pr,"s"));
      %class(uResp)
      if length(uResp)==0
         break
      end
      try
         ab=sscanf(uResp,"%d/%d");
      catch
         fprintf("malformed answer\n");
         %break;
         continue;
      end
      if length(ab)==1
         ab(2)=1;
      end
      a=ab(1);
      b=ab(2);

      % rats/rat would be easier, but there was some error
      % using them, and at the end no need to use them
      
      okA=sg1*a1*b2+sg2*a2*b1;
      okB=b1*b2;
      if okA*b==okB*a
         fprintf("correct\n");
         numOk=numOk+1;
      else
         d=gcd(okA,okB);
         okA=idivide(okA,int32(d),"fix");
         okB=idivide(okB,int32(d),"fix");
         if okB>1
            fprintf(sprintf("no, it is %d/%d\n",okA,okB));
         else
            fprintf(sprintf("no, it is %d\n",okA));
         end
      end
      numAll=numAll+1;
      input("hit ↵ to continue");
   end
   
   fprintf("\n-------------------------\n\n");
   if numAll>0
      % honestly, idk how to print % sign...in a simpler way
      prc="%";
      fprintf("num of questions tried: %d\n", numAll);
      fprintf("correct: %.2f %s", numOk/numAll*100.0,prc);
   end
   eTime=toc(eTime);
   fprintf("elapsed: %.2f sec\n", eTime);
     
end
