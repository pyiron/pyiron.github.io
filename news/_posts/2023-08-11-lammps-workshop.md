---
category: workshop
title: LAMMPS workshop
---
As part of the [LAMMPS Workshop 2023](https://www.lammps.org/workshops/Aug23/) [Jan Janssen](http://www.jan-janssen.com/)
gave a tutorial on pyiron with a specific focus on the [LAMMPS](https://www.lammps.org/) interface in pyiron. The 
tutorial started with the introduction to the pyiron LAMMPS job class, which provides the option to either execute 
existing LAMMPS input scripts with pyiron or use the generic pyiron interface to setup LAMMPS calculation, especially 
for users who are not yet familiar with the input format of the LAMMPS simulation code. The tutorial further covered the
map-reduce approach introduced by the pyiron tables class which allows users to aggregate the results of a large numbers 
of LAMMPS simulation in a pandas dataframe to reuse them with a machine learning framework of choice. Finally, the 
tutorial also covered the calculation of material properties from elastic properties like the bulk modulus and the 
elastic constants, to free energies with the [phonopy package](https://phonopy.github.io/phonopy/) for phonon calculations.

The material for the workshop is available in the [Github repository](https://github.com/pyiron-workshop/lammps-workshop-2023) 
and as [Jupyter book](http://workshop.pyiron.org/lammps-workshop-2023).  