{% highlight python %}
# Edit me!
from pyiron import Project

pr = Project("My_Project")

lammps = pr.create_job(pr.job_type.Lammps, "MD")
lammps.structure = pr.create_ase_bulk("Al", cubic=True)
lammps.calc_md(temperature=800, pressure=0, n_ionic_steps=10000)
lammps.potential = lammps.list_potentials()[0]
lammps.run()
{% endhighlight %}