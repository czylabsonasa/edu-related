% ga_use

akt="ks4.json";

% data=jsondecode(fileread("knapsack_data/"+akt))
% H=length(data.v);
% intlinprog(-data.v,1:H,data.w',data.W,[],[],zeros(H,1),ones(H,1))


[x,fx,fpath,fmeanpath,fstdpath]=ga_edu_sep(ga_ks_adapt("knapsack_data/"+akt));