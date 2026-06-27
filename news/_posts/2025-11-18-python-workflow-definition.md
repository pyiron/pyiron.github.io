---
category: releases
title: Python Workflow Definition
---
In collaboration with the developers of [aiida](https://aiida.net) and [jobflow](https://materialsproject.github.io/jobflow/)
the pyiron developer team released the [Python Workflow Definition](https://pythonworkflow.github.io/python-workflow-definition)
an interoperability format for Python based workflows. In contrast to previous standardization efforts like the 
[Common Workflow Language](https://www.commonwl.org) the Python Workflow Definition is based on sharing Python objects
between consecutive workflows steps, rather than files. This provides a performance advantage in particular for 
high-throughput workflows as they are commonly used in computational materials science. 

Read the publication about the [Python Workflow Definition on Digital Discovery](https://pubs.rsc.org/doi/d5dd00231a).
