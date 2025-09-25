function exercise()
   
   eTime=tic();
   numOk=0;
   numAll=0;
   L=20;
   format rat;
   while 1>0
      a1=randi(L);
      b1=randi(L);
      a2=randi(L);
      b2=randi(L);
      sg1=2*(randi(2)-1)-1;
      sg2=2*(randi(2)-1)-1;
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
      
      pr=sprintf("what is %s%d/%d %s %d/%d ?  ",sg1,a1,b1,op,a2,b2);
      uResp=input(pr,"s");
      %class(uResp)
      if length(uResp)==0, break; end
      try
         uVal=eval(uResp);
      catch
         disp("stg went wrong");
         break;
      end
   
      okVal=sg1*a1/b1+sg2*a2/b2;
      if uVal==okVal
         disp("correct");
         numOk=numOk+1;
      else
         %strOkVal=strip(rats(okVal));
         sOkVal=rats(okVal);
         disp(sprintf("no, it is %s",sOkVal));
      end
      numAll=numAll+1;
   end
   
   disp("\n-------------------------\n");
   if numAll>0
      prc="%";
      disp(sprintf("num of questions: %d", numAll));
      disp(sprintf("correct: %.2f %s", numOk/numAll*100.0,prc));
   end
   eTime=toc(eTime);
   disp(sprintf("elapsed: %.2f sec", eTime));
      
   format;
end
