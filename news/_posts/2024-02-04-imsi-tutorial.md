---
category: workshop
title: Tutorial at the Institute for Mathematical and Statistical Innovation
---
As part of the [Data-Driven Materials Informatics](https://www.imsi.institute/activities/data-driven-materials-informatics/)
program at the [Institute for Mathematical and Statistical Innovation](https://www.imsi.institute) [Jan Janssen](http://www.jan-janssen.com/)
gave a pyiron tutorial with a specific focus on the capabilities of pyiron to enable up-scaling simulation protocols for
the latest generation of Exascale high-performance computers (HPC). The tutorial started with the introduction of the pyiron
job class based on the [LAMMPS](https://www.lammps.org/) simulation code, followed by an introduction of the map-reduce
capabilities of the pyiron table class and concluding with a demonstration how to use pyiron in combination with the 
[flux framework](https://flux-framework.org) job scheduler which allows distributing multiple simulation within a given
allocation of a job scheduler installed on a given HPC, even if [SLURM](https://slurm.schedmd.com) is used as primary 
job scheduler. In addition, the tutorial also demonstrates the implementation of new pyiron job classes on the example 
of the desnity functional theory simulation code [quantum ESPRESSO](https://www.quantum-espresso.org).

The material for the workshop is available in the [Github repository](https://github.com/pyiron-workshop/imsi-tutorial) 
and as [Jupyter book](https://workshop.pyiron.org/imsi-tutorial/).  