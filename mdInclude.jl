# mdInclude.jl
# a quick hack in the morning of 2025 09 22 
# make readme.md from preReadme.md
# TODO: 
# - extend the lang support 
# - the error handling is deficient

module mdInclude
   const _DBG_=true

   ext2lang=Dict(
      "jl"=>"julia",
      "m"=>"matlab",
      "py"=>"python",
      "cc"=>"c++",
   )
   const patt=Regex(raw"{{(?<name>\w+).(?<ext>\w+)}}")

   function frameIt(s,ext)
      _DBG_&&printstyled("frameIt!\n";color=:green)
      """
      ```$(ext2lang[ext])
      $(s)
      ```
      """
   end

   function getPair(m::RegexMatch,folder)
      _DBG_&&printstyled("getPair!\n";color=:green)
      fname="""$(m["name"]).$(m["ext"])"""
      source=read(joinpath(folder,fname),String)
      _DBG_&&println(stderr,source[1:33])
      return """$(m.match)"""=>frameIt(source,m["ext"])
   end

   function Include(dir)
      _DBG_&&printstyled("Include!\n";color=:green)
      for (folder,dirs,files) in walkdir(dir)
         for fi in files
            aFi=abspath(joinpath(folder,fi))
            if basename(aFi)=="preReadme.md"
               _DBG_&&printstyled("\n-> $(aFi)\n";color=:yellow)
               dFi=dirname(aFi)
               aTar=joinpath(dFi,"readme.md")
               if !isfile(aTar) || mtime(aFi)>mtime(aTar)
                  printstyled("   processing\n"; color=:lightyellow)
                  From=read(aFi,String)
                  subs=[]
                  for m in eachmatch(patt,From)
                     push!(subs,getPair(m,folder))
                     _DBG_&&println(stderr,m)
                  end
                  open(aTar,"w") do f
                     println(f,replace(From,subs...))
                  end
               end
            end
            for adir in dirs
               if startswith(adir,"_")
                  finalize(adir)
               end
            end
         end
      end
   end # of finalize

   export Include
end

using .mdInclude

if abspath(PROGRAM_FILE)==@__FILE__
   dir="."
   if(length(ARGS)>0)
      dir=ARGS[1]
   end
   Include(dir)
 end

