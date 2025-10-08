# mdInclude.jl
# a quick hack in the morning of 2025 09 22 
# make stg.md from pre-stg.md by including what is defined to be included
# TODO: 
# - extend the lang support 
# - the error handling is deficient
# github markdown does not play well with detail/summary + source code
# github -> no pdf embedding

module myInclude
   const _DBG_=true

   ext2lang=Dict(
      "jl"=>"julia",
      "m"=>"matlab",
      "py"=>"python",
      "cc"=>"c++",
      "txt"=>"matlab",
   )
   langExt=collect(keys(ext2lang))
   docExt=["pdf"]
   picExt=["png","gif","jpg"]
   knownExt=vcat(langExt,docExt,picExt)
   
   # the substitution pattern
   #do i want the description here?
   #const patt=Regex(raw"{{(?<desc>[^@]+)@(?<name>[^\.]+).(?<ext>\w+)}}")
   const patt=Regex(raw"{{(?<name>[^\.]+).(?<ext>\w+)}}")

   function frameIt(name,ext,path)
      _DBG_&&printstyled("frameIt!\n";color=:green)
      body=if ext in langExt
         src=read(path,String)
         _DBG_&&println(stderr,src[1:33])
         """
         ```$(ext2lang[ext])
         $(src)
         ```
         """
      elseif ext in docExt
         """
         [$(name)]($(name).$(ext))
         """
      elseif ext in picExt
         """
         ![$(name)]($(name).$(ext))
         """
      else
         @assert 1<1 "unknown extension"
      end
      body
   end

#   function frameIt(desc,name,ext,path)
#      _DBG_&&printstyled("frameIt!\n";color=:green)
#      body=if ext in langExt
#         src=read(path,String)
#         _DBG_&&println(stderr,src[1:33])
#         """
         ### $(desc)
#         ```$(ext2lang[ext])
#         $(src)
#         ```
#         """
#      elseif ext in docExt
#         """
#         [$(desc)]($(name).$(ext))
#         """
#      elseif ext in picExt
#         """
#         ![$(desc)]($(name).$(ext))
#         """
#      else
#         @assert 1<1 "unknown extension"
#      end
#      body
#   end



   function getSubPair(m::RegexMatch,folder)
      _DBG_&&printstyled("getSubPair!\n";color=:green)
      #desc,name,ext=m["desc"],m["name"],m["ext"]
      name,ext=m["name"],m["ext"]
      _DBG_&&println(stderr,"$(name) $(ext)")
      if !(ext in knownExt)
         printstyled("unknown extension: $(ext)"; color=:red)
         return
      end
      fname="""$(name).$(ext)"""
      path=joinpath(folder,fname)
      if !isfile(path)
         printstyled("no such file: $(path)"; color=:red)
         return
      end
      return """$(m.match)"""=>frameIt(name,ext,path)
   end

   function Include(dir)
      _DBG_&&printstyled("Include: dir=$(dir)\n";color=:green)
      for (folder,dirs,files) in walkdir(dir)
         false&&_DBG_&&println(stderr,"folder=$(folder)\n dirs=$(dirs)\n files=$(files)\n")
         for fi in files
            aFi=abspath(joinpath(folder,fi))
            basFi=basename(aFi)
            if startswith(basFi,"pre-") && endswith(basFi,".md")
               _DBG_&&printstyled("\n-> $(aFi)\n";color=:yellow)
               dFi=dirname(aFi)
               aTar=joinpath(dFi,basFi[5:end])
               if !isfile(aTar) || mtime(aFi)>mtime(aTar)
                  printstyled("   processing\n"; color=:lightyellow)
                  From=read(aFi,String)
                  subs=[]
                  for m in eachmatch(patt,From)
                     push!(subs,getSubPair(m,folder))
                     _DBG_&&println(stderr,"match: $(m)")
                  end
                  open(aTar,"w") do f
                     println(f,replace(From,subs...))
                  end
               end
            end
         end
         for adir in dirs
            if startswith(adir,"_")
               Include(adir)
            end
         end
      end
   end # of Include

   export Include
end

using .myInclude

if abspath(PROGRAM_FILE)==@__FILE__
   dir="."
   if(length(ARGS)>0)
      dir=ARGS[1]
   end
   Include(dir)
end
