from fractions import Fraction
from tabulate import tabulate
from tomllib import loads as loadToml

#debug=lambda s:print(s)
debug=lambda s: None


import sys
def error(s): sys.exit(s)

def tryread(d,typ,msg):
  try:
    return typ(d)
  except:
    error(msg)
    

clrscr=lambda: None
import time; 

def readData(s):
   try:
      ds=loadToml(s)   
   except:
      print("error in data (toml-parse)")
   
   
# read and convert the data
def data2matrix(data,form="list"):
   if form=="list":
      msg="data2matrix/list/error in data"
      data=data.split()
      ndata=len(data)
      debug("data="+str(data))
      debug("ndata="+str(ndata))
   nvar,varnames,ncond,c,inbase,outbase,table=[None]*7
    i=-1
    while True:
      i+=1
      debug("i="+str(i))
      if i>=ndata: break
      if data[i]=='nvar': 
        i+=1
        nvar=tryread(data[i],int,msg+' 1')
        continue

      if data[i]=='varnames':
        _nvar=tryread(nvar,int,msg+' 2')
        varnames=[""]*_nvar
        for j in range(_nvar):
          i+=1
          varnames[j]=tryread(data[i],str,msg+' 3')
        continue

      if data[i]=='ncond': 
        i+=1
        ncond=tryread(data[i],int,msg+' 4')
        continue
        
      if data[i]=='c':
        _nvar=tryread(nvar,int,msg+' 5')
        c=[Fraction(0,1)]*_nvar
        for j in range(_nvar):
          i+=1
          c[j]=tryread(data[i],Fraction,msg+' 6')
        continue
        
      if data[i]=='inbase':
        _ncond=tryread(ncond,int,msg+' 7')
        inbase=[""]*_ncond
        for j in range(_ncond):
          i+=1
          inbase[j]=tryread(data[i],str,msg+' 8')
        continue

      if data[i]=='outbase':
        _ncond=tryread(ncond,int,msg+' 9')
        _nvar=tryread(nvar,int,msg+' 10')
        outbase=[""]*(_nvar-_ncond)
        for j in range(_nvar-_ncond):
          i+=1
          outbase[j]=tryread(data[i],str,msg+' 11')
        continue
        
      if data[i]=='table':
        _ncond=tryread(ncond,int,msg+' 12')
        _nvar=tryread(nvar,int,msg+' 13')
        table=[[Fraction(0,1)]*(_nvar-_ncond+1) for j in range(_ncond)]
        for j in range(_ncond):
          for k in range(_nvar-_ncond+1):
            i+=1
            table[j][k]=tryread(data[i],Fraction,msg+' 14')
        continue
      # we cannot get here
      #break
      error(msg+' 15')

    debug(str([nvar,varnames,ncond,c,inbase,outbase,table]))
    if None in [nvar,varnames,ncond,c,inbase,outbase,table]:
      error(msg+' 16')
    
    
    # build the matrix from the data:
    matrix=[[i,*r] for (i,r) in zip(inbase,table)]
    matrix=[[None,*outbase,None],*matrix]
    # for convenience we build the dict variant of the objective function 
    dc=dict()
    for v,c in zip(varnames,c):
      dc[v]=c
    # we need (for the change of the basis) a dict for storing the actual locations of the variables
    # (within the matrix)
    var2loc=dict()
    for i in range(1,ncond+1):
      var2loc[matrix[i][0]]=(i,0)
    for j in range(1,nvar-ncond+1):
      var2loc[matrix[0][j]]=(0,j)
    # now we are prepared to build the bottom row
    br=[Fraction(0,1)]*(nvar-ncond+1); br=[None,*br]
    
    c_in=[0,*[dc[v] for v in inbase]]
    for j in range(1,nvar-ncond+1):
      cj=dc[matrix[0][j]]
      zj=Fraction(0,1)
      for i in range(1,ncond+1):
        zj+=c_in[i]*matrix[i][j]
      br[j]=zj-cj
    # objective function value
    z=sum(c_in[i]*matrix[i][-1] for i in range(1,ncond+1))
    br[-1]=z
    matrix=[*matrix,br]
    
    return matrix, var2loc
  

  if form=="table":
    msg="data2matrix/table/error in data"
    matrix=[r.split() for r in data.split('\n') if len(r)>0]
    if len(matrix)==0 or len(matrix[0])==0: 
      error(msg)
      
    nrow=len(matrix)
    ncol=len(matrix[0])
    for r in matrix:
      if len(r)!=ncol: 
        error(msg)
    
    #debug("table:"+str(table))
    noutbase=ncol-2
    ninbase=nrow-2
    ncond=nrow
    nvar=noutbase+ninbase
    if noutbase<1 or ninbase<1: 
      error(msg)

    var2loc=dict()
    for i in range(0,nrow):
      for j in range(0,ncol):
        if i==0 and j==0: 
          continue
        if i==0 or j==0: # variable name (column of the coeff matrix)
          matrix[i][j]="".join(filter(lambda x:x not in "[]",matrix[i][j]))
          var2loc[matrix[i][j]]=(i,j)
          matrix[i][j]=matrix[i][j]
        else:
          #debug("else:"+str(matrix[i][j]))
          try:
            matrix[i][j]=Fraction(matrix[i][j])
          except:
            error(msg)
            
    return matrix,var2loc


# assumption: the table is a proper one, i.e. returned by
# data2matrix or make_chob (chob=change of basis)
# o:leaves the basis 
# i:enters ...
def make_chob(omatrix,var2loc,o,i):
  matrix=[r.copy() for r in omatrix]
  nrow=len(omatrix)
  ncol=len(omatrix[0])
  matrix[0][i],matrix[o][0]=matrix[o][0],matrix[0][i]
  var2loc[matrix[0][i]]=(0,i)
  var2loc[matrix[o][0]]=(o,0)
  piv=matrix[o][i]
  
  # here is the change of basis
  for to in range(1,nrow):
    for ti in range(1,ncol):
      if to==o and ti==i: 
        matrix[to][ti]=1/piv
        continue
      if to==o:
        matrix[to][ti]=omatrix[to][ti]/piv
        continue
      if ti==i:
        matrix[to][ti]=-omatrix[to][ti]/piv
        continue
      matrix[to][ti]=omatrix[to][ti]-omatrix[to][i]*omatrix[o][ti]/piv
  
  return matrix,var2loc


def matrix2table(matrix):
  # currently the layout used for tabulate is fixed
  tmatrix=[r.copy() for r in matrix]
  nrow=len(tmatrix)
  ncol=len(tmatrix[0])
  tmatrix[0][0]="ι/ω"
  tmatrix[0][-1]="b"
  tmatrix[-1][0]="βρ"
  #print(tmatrix)
  for j in range(1,ncol):
    tmatrix[0][j]='['+tmatrix[0][j]+']'
  for i in range(1,nrow-1):
    tmatrix[i][0]='['+tmatrix[i][0]+']'
  return tabulate([map(str,r) for r in tmatrix], 
                  tablefmt="fancy_grid",stralign="right")


# first iteration of the main program
def play_with_simplex(data,form="list"):
  matrix,var2loc=data2matrix(data,form=form)
  table_id=0
  while True:
    clrscr()
    print(matrix2table(matrix),flush=True)
    cmd=input("cmd: ")
    if cmd=="":
      continue
    clist=cmd.split()
    if cmd[0][0] in ["x","X"]:
      print("exit",flush=True)
      return
    if len(clist)!=2:
      continue
    go_out,go_in=clist
    if go_out==go_in:
      continue
    loc_out=var2loc.get(go_out,None)
    loc_in=var2loc.get(go_in,None)
    if None in [loc_out,loc_in]:
      continue
    if loc_out[1]!=0 or loc_in[0]!=0:
      continue
    matrix,var2loc=make_chob(matrix,var2loc,loc_out[0],loc_in[1])
    table_id+=1
