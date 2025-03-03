function graph_dict(E,V)
    tic;
    disp("testing dictionary()");


    G = configureDictionary("int64", "logical");
    B = 1000000000;
    edge2num = @(v) int64(B*v(1)+v(2));
    
    
    % insert
    %V=3000; % 1...V csocsokat general
    %E=30000; % ennyiszer general elet
    for it=1:E
        e = randi(V,2,1); 
        % csere, mert iranyitatlan
        if e(1)>e(2) 
            e([1,2])=e([2,1]);
        end
    
        num_e=edge2num(e);
        if lookup(G,num_e,"FallbackValue",false)==false
            G(num_e)=true;
        end
    end
    
    
    % query
    K = 0;
    for it=1:E
        e = randi(V,2,1); 
        if e(1)>e(2) 
            e([1,2])=e([2,1]);
        end
    
        num_e=edge2num(e);
        if lookup(G,num_e,"FallbackValue",false)==true
            K=K+1;
        end
    end
    disp(K/E);
    toc;
end