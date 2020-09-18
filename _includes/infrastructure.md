{% highlight python %}
from pyiron import Project

pr = Project("My_Project")
for i,elt in enumerate(periodic_table):
  	job = pr.create_job(pr.job_type.Lammps, f"Lammps_{i}")
    job.structure = pr.create_ase_bulk(elt, cubic=True)
    job.potential = job.list_potentials()[0]
    job.run()
{% endhighlight %}