### about
- simple helper routine to study floating point systems
- named parameters should be used
- the order is not imprtant
- some examples can be found in [usage_floatsys.m](usage_floatsys.m).


```matlab
% funs=floatsys()
%    A small lib that provides floating point system related functions. 
%    A struct `funs` with various useful functions (as fields), see below.
%
%    The actual floating point systems are represented by a struct 'myfs' 
%    with fields 'a,kminus,kplus,t'. it is used widely as parameter for the
%    functions of this lib.
%
%    fs=default_fs()
%       It return a default floating point system (=struct) with
%       fields a=2,kminus=-4,kplus=4,t=4
%
%
%    d=digits(x=x,a=a)
%       For a given nonnegative 'x' integer returns a vector of its digits
%       in base 'a'.
%
%
%    nums=important_numbers(a=a,kminus=kminus,kplus=kplus,t=t)
%       For a given `a,kminus,kplus,t` it returns some important numbers of the
%       system represented by 'a,kminus,kplus,t'
%
%
%    e=expand_dec(x=x,a=a,d=d)
%       It returns the 'a'-ary (e.g. binary for a=2) expansion of 'x' for 'd'
%       digits, it works only for 0<x<1.
%       note that, x should be given in decimal notation
%
%
%    !!!not implemented yet
%    e=expand_rat(A=A,B=B,a=a,d=d)
%       It returns the 'a'-ary (e.g. binary for a=2) expansion of 'A/B' for 'd'
%       digits, it works only for 0<A/B<1.
%       x should be given in decimal notation
%
%    r=represent(x=x, a=a, kminus=kminus, kplus=kplus, t=t)
%       Returns the representation of 'x' in the system 'a,kminus,kplus,t'
%
%

function funs=floatsys()
   funs=struct( ...
      default_fs=@default_fs,...
      digits=@digits,...
      important_numbers=@important_numbers,...
      expand=@expand,...
      represent=@represent...
   );
end

% helper
function fs=default_fs()
   fs=struct(...
      a=2,...
      kminus=-4,...
      kplus=4,...
      t=5 ...
   );
end

% for a given nonnegative 'n' integer returns a vector of its digits in base 'a'
function d=digits(args)
   arguments
      args.x = 2
      args.a = 2
      args.show = 1
   end
   x=args.x;
   a=args.a;
   
   %%%%%%%%%%%%%%%%%%%
   
   d=[];
   while true
      d=[d,mod(x,a)];
      x=floor(x/a);
      if x<1, break; end
   end
   d=d(end:-1:1);
   if args.show>0
      fprintf("   %d(10)=%s(%d)\n",args.x,strjoin(string(d),""),args.a);
   end
end


% For a given system `a,kminus,kplus,t` it returns some important numbers
function nums=important_numbers(args)
   arguments
      args.a=2
      args.kminus=-4
      args.kplus=4
      args.t=5
      args.show=1
   end
   a=args.a;
   kminus=args.kminus;
   kplus=args.kplus;
   t=args.t;

   %%%%%%%%%%%%%%%%%%%

   nums=struct( ...
      normalized_positive=(kplus-kminus+1)*(a-1)*a^(t-1),...
      largest=a^kplus*(1-1/a^t),...
      smallest=a^(kminus-1),...
      epsilon1=a^(1-t),...
      oneplus=1+a^(1-t),...
      oneminus=1-a^(-t)...
   );

   if args.show>0
      disp(nums)
   end

end



% It returns the 'a'-ary (aka. binary for a=2) expansion of 'x' for 'd' digits
% after the dot. 'e': vector of digits. it works for 0<x<1
% x should be given in decimal notation
function xpn=expand_dec(args)
   arguments
      args.x = 1/3
      args.a = 2
      args.d = 10
      args.show = 1
   end
   x=args.x;
   a=args.a;
   d=args.d;

   %%%%%%%%%%%%%%%%%%%
   if args.show>0
      show=@(x) fprintf("   %.10f\n",x); 
   else
      show=@(x) 0;
   end

   show(x);if args.show>0, fprintf("   %s\n",strjoin(repmat("-",1,d+2),""));end
   xpn=zeros(1,d);
   for i=1:d
      x=a*x;
      show(x);
      xpn(i)=floor(x);
      x=x-floor(x);
   end
end




% given 'x' and a 'a,kminus,kplus,t' it returns the 
% normalized representation of 'x' in the floating point system 
% {a,kminus,kplus,t}
% currently works only for 0<x<1, overflow and underflow checking are done
function r=represent(args)
   arguments
      args.x=1/3
      args.a=2
      args.kminus=-4
      args.kplus=4
      args.t=5
      args.show=1
   end
   a=args.a;
   kminus=args.kminus;
   kplus=args.kplus;
   t=args.t;
   x=args.x;


   %%%%%%%%%%%%%%%%%%%
   if args.show>0
      show=@(x)fprintf("%f\n",x);
      show(x);
      fprintf("------------------\n");
   else
      show=@(x)0;
   end

   digit=[];
   i=1; flag=0; % flag is 1 if there was a nonzero digit before
   ii=1; % all of the digits
   while i<=t+1
      x=a*x;
      show(x);
      fx=floor(x);
      if flag<1 && fx>0
         flag=ii; 
      end
      digit=[digit,fx];
      x=x-floor(x);
      i=i+(flag>0);
      ii=ii+1;
   end
   flag;
   digit=digit(flag:end);
   exponent=-(flag-1);

   human=sprintf("+%d^(%d) 0.%s",a,exponent,strjoin(string(digit),""));

   if args.show>0
      fprintf("\n%f = %s\n",args.x, human);
   end
   
   r=struct( ...
      x=args.x,...
      a=a,...
      exponent=exponent,...
      digit=digit,...
      human=human...
   );

end
```
