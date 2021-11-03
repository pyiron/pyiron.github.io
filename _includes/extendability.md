```python
from pyiron_base import PythonTemplateJob

class ToyJob(PythonTemplateJob):
    def __init__(self, project, job_name):
        super().__init__(project, job_name) 
        self.input.energy = 100  # Define default input
    
    def run_static(self):  # Call a python function and store stuff in the output
        self.output.double = self.input.energy * 2
        self.status.finished = True
        self.to_hdf()

job = pr.create_job(job_type=ToyJob, job_name="toy")  # Create job instance
job.run()  # Execute Custom job class 
```
