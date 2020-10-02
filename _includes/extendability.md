```python
from pyiron_base import PythonTemplateJob

class ToyJob(PythonTemplateJob):  # Create a custom job class
    def __init__(self, project, job_name):
        super().__init__(project, job_name) 
        self.input['input_energy'] = 100  # Define default input
    
    def run_static(self):  # Call a python function 
        self["user/result"] = self.input["input_energy"]
        self.status.finished = True  

job = pr.create_job(job_type=ToyJob, job_name="toy")  # Create job instance
job.run()  # Execute Custom job class 
```
