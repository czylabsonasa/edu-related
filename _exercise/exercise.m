function exercise()
   L=20;
   format rat;
   while 1>0
      a1=randi(2*L)-L;
      b1=randi(L);
      a2=randi(2*L)-L;
      b2=randi(L);
      pr=sprintf("what is %d/%d + %d/%d ?  ",a1,b1,a2,b2);
      uResp=input(pr,"s");
      if uResp==""
         break;
      end
      try
         uVal=eval(uResp);
      catch
         disp("stg went wrong");
      end
   
      if uVal==a1/b1+a2/b2
         disp("correct");
      else
         mVal=strip(rats(a1/b1+a2/b2));
         disp(sprintf("no, it is %s",mVal));
      end
   end
   format;
end