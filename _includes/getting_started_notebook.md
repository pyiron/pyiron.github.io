# Introduction

The notebook below is powered by MyBinder, a free remote Jupyter server
where pyiron is already installed. Feel free to modify and add your own
code to what's already there!

If you are having connection issues for any of the cells on this page,
please try launching the [actual MyBinder server](https://mybinder.org/v2/gh/pyiron/pyiron/master)
and running the code there under `notebooks/first_steps.ipynb`

This section gives a brief introduction about fundamental concepts of pyiron and how they can be used to setup, run and analyze atomic simulations. As a first step we import the libraries numpy for data analysis and matplotlib for visualization.

{% highlight python %}
import numpy as np
%matplotlib inline
import matplotlib.pylab as plt
{% endhighlight %}

To import pyiron simply use:

{% highlight python %}
from pyiron import Project
{% endhighlight %}

The Project object introduced below is central in pyiron. It allows to name the project as well as to derive all other objects such as structures, jobs etc. without having to import them. Thus, by code completion Tab the respective commands can be found easily.

We now create a pyiron Project named 'first_steps'.

{% highlight python %}
pr = Project(path='first_steps')
{% endhighlight %}

The project name also applies for the directory that is created for the project.

## Perform a LAMMPS MD simulation

Having created an instance of the pyiron Project we now perform a [LAMMPS](https://lammps.sandia.gov/) molecular dynamics simulation.

For this basic simulation example we construct an fcc Al crystal in a cubic supercell (`cubic=True`). For more details on generating structures, please have a look at our [structures example here](https://mybinder.org/v2/gh/pyiron/pyiron/master).

{% highlight python %}
basis = pr.create_ase_bulk('Al', cubic=True)
supercell_3x3x3 = basis.repeat([3, 3, 3])
supercell_3x3x3.plot3d()
{% endhighlight %}

Here `create_ase_bulk` uses the [ASE bulk module](https://wiki.fysik.dtu.dk/ase/ase/build/build.html). The structure can be modified - here we extend the original cell to a 3x3x3 supercell (`repeat([3, 3, 3]`). Finally, we plot the structure using [NGlview](https://nglviewer.org/nglview/latest/api.html).

The project object allows to create various simulation job types. Here, we create a LAMMPS job.

{% highlight python %}
job = pr.create_job(job_type=pr.job_type.Lammps, job_name='Al_T800K')
{% endhighlight %}

Further, we specify a Molecular Dynamics simulation at $$T=800$$ K using the supercell structure created above.

{% highlight python %}
job.structure = supercell_3x3x3
job.calc_md(temperature=800, pressure=0, n_ionic_steps=10000)
{% endhighlight %}

To see all available interatomic potentials which are compatible with the structure (for our example they must contain Al) and the job type (here LAMMPS) we call `job.list_potentials()`.

{% highlight python %}
job.list_potentials()
{% endhighlight %}

From the above let us select the first potential in the list.

{% highlight python %}
pot = job.list_potentials()[0]
print ('Selected potential: ', pot)
job.potential = pot
{% endhighlight %}

To run the LAMMPS simulation (locally) we now simply use:

{% highlight python %}
job.run()
{% endhighlight %}

## Analyze the calculation

After the simulation has finished the information about the job can be accessed through the Project object.

{% highlight python %}
job = pr['Al_T800K']
job
{% endhighlight %}

Printing the job object (note that in Jupyter we don't have to call a print statement if the variable/object is in the last line). The output lists the variables (nodes) and the directories (groups). To get a list of all variables stored in the generic output we type:

{% highlight python %}
job['output/generic']
{% endhighlight %}

An animated 3d plot of the MD trajectories is created by:

{% highlight python %}
job.animate_structure()
{% endhighlight %}

To analyze the temperature evolution we plot it as function of the MD step.

{% highlight python %}
temperatures = job['output/generic/temperature']
steps = job['output/generic/steps']
plt.plot(steps, temperatures)
plt.xlabel('MD step')
plt.ylabel('Temperature [K]');
{% endhighlight %}

In the same way we can plot the trajectories.

{% highlight python %}
pos = job['output/generic/positions']
x, y, z = [pos[:, :, i] for i in range(3)]
sel = np.abs(z) < 0.1
fig, axs = plt.subplots(1,1)
axs.scatter(x[sel], y[sel])
axs.set_xlabel('x [$\AA$]')
axs.set_ylabel('y [$\AA$]')
axs.set_aspect('equal', 'box');
{% endhighlight %}

## Perform a series of jobs

To run the MD simulation for various temperatures we can simply loop over the desired temperature values.

{% highlight python %}
for temperature in np.arange(200, 1200, 200):
    job = pr.create_job(pr.job_type.Lammps, 
                        'Al_T{}K'.format(int(temperature)))
    job.structure = supercell_3x3x3
    job.potential = pot     
    job.calc_md(temperature=temperature, 
                pressure=0, 
                n_ionic_steps=10000)
    job.run()
{% endhighlight %}

To inspect the list of jobs in our current project we type (note that the existing job from the previous excercise at $$T=800$$ K has been recognized and not run again):

{% highlight python %}
pr
{% endhighlight %}

We can now iterate over the jobs and extract volume and mean temperature.

{% highlight python %}
vol_lst, temp_lst = [], []
for job in pr.iter_jobs(convert_to_object=False):
    volumes = job['output/generic/volume']
    temperatures = job['output/generic/temperature']
    temp_lst.append(np.mean(temperatures[:-20]))
    vol_lst.append(np.mean(volumes[:-20]))
{% endhighlight %}

Then we can use the extracted information to plot the thermal expansion, calculated within the $$NPT$$ ensemble. For plotting the temperature values in ascending order the volume list is mapped to the sorted temperature list.

{% highlight python %}
plt.figure()
vol_lst[:] = [vol_lst[np.argsort(temp_lst)[k]] 
              for k in range(len(vol_lst))]
plt.plot(sorted(temp_lst), vol_lst, 
         linestyle='-',marker='o',)
plt.title('Thermal expansion')
plt.xlabel('Temperature [K]')
plt.ylabel('Volume [$\AA^3$]');
{% endhighlight %}

## Create a series of projects

We extend the previous example and compute the thermal expansion for three of the available aluminum potentials. First, let us create a new pyiron project named 'Al_potentials'. We can use the information of the previously run job 'Al_T200K' of the 'first_steps' project to find all the compatible potentials.

{% highlight python %}
pr = Project('Al_potentials')
pot_lst = pr['../first_steps/Al_T200K'].load_object().list_potentials()[:3]
{% endhighlight %}

{% highlight python %}
pot_lst
{% endhighlight %}

Note again that `list_potentials()` automatically only returns the potentials that are compatible with the structure (chemical species) and the job type.

We can now loop over the selected potentials and run the MD simulation for the desired temperature values for any of the potentials.

{% highlight python %}
for pot in pot_lst:
    print ('Interatomic potential used: ',pot)
    pr_pot = pr.create_group(pot)
    for temperature in np.arange(200, 1200, 200):
        job = pr_pot.create_job(pr.job_type.Lammps, 
                                'Al_T{}K'.format(int(temperature)))
        job.structure = supercell_3x3x3
        job.potential = pot                
        job.calc_md(temperature=temperature, 
                    pressure=0, 
                    n_ionic_steps=10000)
        job.run()
{% endhighlight %}

With the `pr.create_group()` command a new subproject (directory) is created named here by the name of the potential. 

For any particular potential the thermal expansion data can be obtained again by looping over the jobs performed using that potential. To obtain the thermal expansion curves for all the potentials used we can simply iterate over the subprojects (directories) created above by using the `pr.iter_groups()` command.

{% highlight python %}
for p in pr.iter_groups():
    vol_lst, temp_lst = [], []
    for out in p.iter_jobs(path='output/generic'):
        volumes = out['volume']
        temperatures = out['temperature']
        temp_lst.append(np.mean(temperatures[:-20]))
        vol_lst.append(np.mean(volumes[:-20]))
    # Plot only if there is a job in that group
    if len(p.get_job_ids()) > 0:
        plt.plot(temp_lst, vol_lst, 
                 linestyle='-',marker='o',
                 label=p.name) 
plt.legend(loc='best')    
plt.title('Thermal expansion for different interatomic potentials')
plt.xlabel('Temperature [K]')
plt.ylabel('Volume [$\AA^3$]');
{% endhighlight %}