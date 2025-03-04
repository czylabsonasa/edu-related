function main()
   msg(x)=printstyled(x,color=:light_yellow)

   if length(ARGS)!=2
      msg(
"""
hide: simple xor [en/de]coder for hiding files temporarily
usage: julia hide.jl pathtofile PASS
(of course you should remember the PASS to get back the original content)
"""
      )
      exit(1)
   end

   fname, pass=ARGS
   if !isfile(fname)
      msg("$(fname): no such file\n")
      exit(2)
   end

   # soft/hard links?
   if abspath(PROGRAM_FILE)==abspath(ARGS[1])
      msg("suicide?...don't.\n")
      exit(3)
   end   

   p_as_uint8=Vector{UInt8}(pass)
   f_as_uint8=read(fname)

   lpass=length(p_as_uint8)
   lf=length(f_as_uint8)
   q,r=divrem(lf,lpass)

   pp_as_uint8=repeat(p_as_uint8,q)
   if r>0
      pp_as_uint8=vcat(pp_as_uint8, p_as_uint8[1:r])
   end
   
#   println(length(f_as_uint8), " ", length(pp_as_uint8))

   ff_as_uint8=xor.(f_as_uint8,pp_as_uint8)

   write(fname,ff_as_uint8)


   msg("OK\n")
end


main()
