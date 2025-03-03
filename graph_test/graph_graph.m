function graph_graph(E,V)
    tic;
    disp("testing graph()");

    G=graph();
%    G=addnode(G,V);

    % insert
    for it = 1:E
        e=randi(V,2,1);
        G=addedge(G,e(1),e(2));
    end
    
    
    % guery
    K=0; % ennyit talalunk meg a grafban
    for it = 1:E
        e=randi(V,2,1);
        idx=findedge(G,e(1),e(2));
        if idx>0
            K=K+1;
        end
    end
    disp(K/E);
    toc;
end    

