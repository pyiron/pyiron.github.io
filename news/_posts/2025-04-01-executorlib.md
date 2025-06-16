---
category: releases
title: executorlib package release 
---
As part of the modularization strategy of pyiron, we are happy to announce the release of [executorlib version 1.0](https://github.com/pyiron/executorlib/releases/tag/executorlib-1.0.0).

With [executorlib](https://github.com/pyiron/executorlib) you can up-scale python functions for high performance 
computing (HPC), including support for [mpi4py](https://mpi4py.readthedocs.io/), multi-threading and GPUs. It is 
compatible with the [simple linux utility for resource management (SLURM)](https://slurm.schedmd.com) and the 
hierarchical resource manager [flux](https://flux-framework.org). Resulting in minimal overhead as executorlib directly 
communicates with the job scheduler without data replication or an intermediate database. Available as part of 
[pyiron_base](https://github.com/pyiron/pyiron_base) and as standalone open-source library. 

The corresponding article was published in the [Journal of Open Source Software](https://doi.org/10.21105/joss.07782), the
source code is available on [Github](https://github.com/pyiron/executorlib) as part of the [pyiron organisation](https://github.com/pyiron)
including the [documentation](https://executorlib.readthedocs.io/).
