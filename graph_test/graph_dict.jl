function build_graph(E,V=E)
  G = Dict{Tuple{Int,Int},Int}()
  for it in 1:E
      (a,b)=rand(1:V,2)
      G[(a,b)]=get(G,(a,b),0)+1
  end
  G
end

