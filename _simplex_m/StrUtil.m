function SU=StrUtil()
   function S=zeros0(nRow,nCol)
      S=repelem("",nRow,nCol);
   end

   function S=split0(s)
      S=strsplit(s," ");
      S=S(S>"");
   end

   function M=readtable0(fname)
      L=readlines(fname);
      M=[];
      nR=0;
      nC=0;
      for it=1:length(L)
         sp=split0(L(it));
         hSp=length(sp);
         if hSp>0
            assert(nR==0 || hSp==nR,"error: data file");
            nR=hSp;
            nC=nC+1;
            M=[M;sp];
         end
      end
   end
   
   function S=strtable0(M)
      nR=size(M,1);
      nC=size(M,2);
      al=max(strlength(M(:)))+4;
      M(1,1)="";
      for x=1:nR
         for y=1:nC
            M(x,y)=sprintf("%*s",al,M(x,y));
         end
      end
      S=[];
      for x=1:nR
         S=[S,strjoin(M(x,:))];
      end
      S=strjoin(S,"\n");
   end


   SU.zeros=@zeros0;
   SU.split=@split0;
   SU.readtable=@readtable0;
   SU.strtable=@strtable0;
end