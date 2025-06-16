---
category: releases
title: pyiron 0.3.X - HPC release
---
After the recent success of pyiron and pyiron being used in a series of [publications](https://pyiron.org/publications/) 
we received the feedback that requiring an SQL database on the HPC cluster is still prohibitive for many institutions. 
We therefore now also support SSH based communication between the HPC cluster and either a local workstation and a group 
server. We still believe that having a central server rather than an individual installation for each group member 
simplifies the reproducibility and sharing within a research group, but now it is in principle also possible to transfer
all calculation results back to the users workstation. The HPC integration is currently in a testing phase, meaning the 
code is available online but the documentation is still in progress. Therefore if you are interested to use pyiron with 
your HPC cluster do not hesitate to contact us.
