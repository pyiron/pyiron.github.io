---
title: "Application-specific machine-learned interatomic potentials: exploring the trade-off between DFT convergence, MLIP expressivity, and computational cost"
journal: Digital Discovery, 2026, 5, 332-347
authors:
  - Ilgar Baghishov 
  - Jan Janssen
  - Graeme Henkelman
  - Danny Perez
abstract: Machine-learned interatomic potentials (MLIPs) are revolutionizing computational materials science and chemistry by offering an efficient alternative to ab initio molecular dynamics (MD) simulations. However, fitting high-quality MLIPs remains a challenging, time-consuming, and computationally intensive task where numerous trade-offs have to be considered, e.g., How much and what kind of atomic configurations should be included in the training set? Which level of ab initio convergence should be used to generate the training set? Which loss function should be used for fitting the MLIP? Which machine learning architecture should be used to train the MLIP? The answers to these questions significantly impact both the computational cost of MLIP training and the accuracy and computational cost of subsequent MLIP MD simulations. In this study, we use a configurationally diverse beryllium dataset and quadratic spectral neighbor analysis potential. We demonstrate that joint optimization of energy versus force weights, training set selection strategies, and convergence settings of the ab initio reference simulations, as well as model complexity can lead to a significant reduction in the overall computational cost associated with training and evaluating MLIPs. This opens the door to computationally efficient generation of high-quality MLIPs for a range of applications which demand different accuracy versus training and evaluation cost trade-offs.
full-text: https://doi.org/10.1039/D5DD00294J
---