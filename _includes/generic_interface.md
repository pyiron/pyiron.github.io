```python
from pyiron import Project # Import Project object 

pr = Project("demonstration")  # Create a project/folder 
structure = pr.create_ase_bulk("Al")  # Create an aluminium bulk structure
for job_type in ["Gpaw", "Lammps", "Sphinx"]:  # Iterate over simulation codes
    job = pr.create_job(  # Create a job object
        job_type=job_type, 
        job_name=job_type
    )
    job.structure = structure  # assign the structure 
    # job.server.queue = "my_queue"  # uncomment to up-scale to HPC 
    # job.server.cores = 4  # Set number of cores
    job.run()  # Execute the calculation
```
