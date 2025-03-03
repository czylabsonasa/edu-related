clc; clear;

% manual hash
infNode=100000; % node inices are less than maxNode
infEdge=100000; % less than infEdge edges under consideration
infTable=2*infEdge;

edgestore=zeros(3,infTable); % the columns are the edges (additional info can be stored in a third,... row)

edge2key = @(v) int64(infNode*v(1)+v(2));
for it=1:infEdge
    v=randi(infNode-1,2,1);
    t=edge2key(v);
    loc=mod(t,infTable);
    while true
        if all(edgestore(1:2,loc)==v)
            edgestore(3,loc)=edgestore(3,loc)+1;
            break
        end
        if sum(edgestore(1:2,loc))==0
            edgestore(3,loc)=1;
            break
        end
        loc=loc+17; % must relative prime w/ infTable (odd prime is ok)
        if loc>infTable, loc=1; end
    end
end

