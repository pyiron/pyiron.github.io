---
title: "When more data hurts: Optimizing data coverage while mitigating diversity-induced underfitting in an ultrafast machine-learned potential"
journal: Phys. Rev. Materials 9, 043802
authors:
  - Jason B. Gibson
  - Tesia D. Janicki
  - Ajinkya C. Hire
  - Chris Bishop
  - J. Matthew D. Lane
  - Richard G. Hennig
abstract: Machine-learned interatomic potentials (MLIPs) are becoming an essential tool in materials modeling. However, optimizing the generation of training data used to parametrize the MLIPs remains a significant challenge. This is because MLIPs can fail when encountering local enviroments too different from those present in the training data. The difficulty of determining a priori the environments that will be encountered during molecular dynamics simulation necessitates diverse, high-quality training data. This study investigates how training data diversity affects the performance of MLIPs using the Ultra-Fast force field (UF3) to model amorphous silicon nitride. We employ expert and autonomously generated data to create the training data and fit four force field variants to subsets of the data. Our findings reveal a critical balance in training data diversity insufficient diversity hinders generalization, while excessive diversity can exceed the MLIP's learning capacity, reducing simulation accuracy. Specifically, we found that the UF3 variant trained on a subset of the training data, in which nitrogen-rich structures were removed, offered vastly better prediction and simulation accuracy than any other variant. By comparing these UF3variants, we highlight the nuanced requirements for creating accurate MLIPs, emphasizing the importance of application-specific training data to achieve optimal performance in modeling complex material behaviors.
full-text: https://doi.org/10.1103/PhysRevMaterials.9.043802
---
