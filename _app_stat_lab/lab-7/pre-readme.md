### lab-7

#### the labor files
- [first part](lab-7-1.pdf)
- second part
  - [mlx](lab-7-2.mlx)
  - [pdf](lab-7-2.pdf)
- third part - Questions
  - [mlx](lab-7-3-Q.mlx)
  - [pdf](lab-7-3-Q.pdf)
- third part - Questions+Answers
  - [mlx](lab-7-3-QA.mlx)
  - [pdf](lab-7-3-QA.pdf)

#### data
- do not forget to check the presence of missing values
  - for numerical arrays they are represented by `nan`-s
  - `isnan`+indexing by logical array (filtering)
- [ustemp original](../data/ustemp.txt)
- [ustemp modified](../data/ustemp_mod.txt)
- [covid](../data/covid.csv)

#### vocabulary
- boxplot, bar
- median, quartile, IQR, extreme value, outlier
- ecdf
- mean, var, std
- load, mat-file, readtable
- corr
- tabulate, cell2table, table.field syntax
  - categorical - works without it
- flip



#### cdf/ecdf plots by hand
- we don't want vertical lines in function plots
- in practice just use `ecdf`

{{piecewise_constant.m}}
