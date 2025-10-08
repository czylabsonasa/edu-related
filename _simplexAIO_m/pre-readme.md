### simplex table computations
- all in one version
- simplex tables w/o hand computations, but you should decide the swaps.
- the rationals used are based on int64. (different from the builtin rat/rats).
  - beware of overflow, it is not suited for extreme cases.
- hand-made: representing [rationals](FracUtil2.m), reading,printing the [corresponding string forms](StrUtil.m) and 
storing them in an appropriate [collection](VecTab.m).
- no classes, only the subfunction feature used (as in python,julia,D).
- you should set up the initial table
- not well tested
  - TODO: perform more tests


#### sample data file
{{data.txt}}


#### sample session
{{session.m}}


