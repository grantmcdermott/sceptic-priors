# *R* replication code for "Sceptic priors and climate policy"

The main file for running the analysis is **`sceptic.R`**. This file contains self-explanatory code for replicating the results from the primary model runs described in the paper. The summary version is that running this file (script) will execute a series of nested loops — looping over different prior types and climate scenarios. During each loop, the code will call several subsidiary scripts (e.g. `scep_funcs.R`, `jags-loop.R`, etc.) to run the Bayesian regressions, save the posterior results for later, or export them as figures and .tex files. 

In addition, a number of supplementary regressions and simulations are described in the `Evidence`, `Recursive`, and `Robustness` sub-directories. All of these supplementary exercises are similarly self-contained, in the sense that they should execute fully upon running a single parent script. See the respective README files for details.

## Performance

The core analysis in this paper involves a series of Bayesian regressions using Markov Chain Monte Carlo (MCMC) simulations. The code is optimized to run in parallel and will automatically exploit any multi-core capability on your machine. On my system (quad core CPU with 16GB RAM), the main `sceptic.R` script only takes around two minutes to run. (Users with older machines can speed things up by reducing the length of the MCMC chains: `chain_length <- ...` on +/- line 12 of the `sceptic.R` parent file.) However, some of secondary analyses contained in the `Recursive` and `Evidence` directories take considerably longer to run. See the respective README files in those directories for more details, but consider this fair warning.