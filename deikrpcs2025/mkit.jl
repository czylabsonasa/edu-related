#!/home/nosy/.juliaup/bin/julia

run(`pandoc --mathml readme.md -o index.html`)
rm("stuff.tgz"; force=true)
dname=basename(pwd())
cd("..")
run(`tar czf stuff.tgz $(dname)`)
run(`mv stuff.tgz $(dname)/stuff.tgz`)

