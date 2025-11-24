rng(2222);
n=40;
data.v=randi([10,100],n,1);
data.w=randi([10,22],n,1);
data.W=ceil(sum(data.w)/2);

hzs=hatizsak();
hzs.init(data);
hzs.ilp();
if n<22, hzs.naive(); end
if n<30, hzs.simple_cut(); end
hzs.dantzig_cut();