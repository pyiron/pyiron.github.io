---
category: releases
title: pyiron 0.2.17 - interactive release
---
Based on the feedback of the first public pyiron release we implemented interactive communication between the simulation 
codes and pyiron. This interactive communication starts the simulation code in a subprocess and then communicates 
changes during the run time back and forth between the simulation code and pyiron. In contrast to the already existing 
file based communication, this approach is much more flexible and faster. It enabled us to control minimisations and 
advanced molecular dynamics protocols in Python rather than integrating them directly in the simulation code. Currently, 
pyiron supports python bindings, socket based communication and unix pipes for communicating with simulation codes. 
While technically the interactive mode requires a completely different interface compared to the previous file based 
communication, for the pyiron user it is as easy as changing a single variable. In total pyiron 0.2.X was 
[downloaded 30 000 times](https://anaconda.org/conda-forge/pyiron) and we are proud to support a continuously growing 
community of pyiron users.
