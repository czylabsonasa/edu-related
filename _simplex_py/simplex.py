# rewrite

from fractions import Fraction
from tabulate import tabulate
from tomllib import loads
from pathlib import Path

def readData(f):
   try:
      s=Path(f).read_text()
   except:
      print("no such file")
      return
      
   try:
      ds=loads(s)   
   except:
      print("error parsing toml")
      return
   
   return ds

def validateData(ds):
   if None in [ds.get(v,None) for v in ["nVar", "nCond", "varNames", "obj", "inVar", "outVar", "table"]]:
      print("missing field in toml"
      return
   var2kind={}
   var2loc={}
   for v in varNames.split():
      var2kind[v]=None
      var2loc[v]=None
   
