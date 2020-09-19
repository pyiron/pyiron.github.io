{% highlight python %}
from pyiron import Project
import os
import numpy as np
import matplotlib.pylab as plt
{% endhighlight %}

{% highlight python %}
pr = Project("ChargedRelax")
job = pr.create_job(
    job_type=pr.job_type.Sphinx,
    job_name="Al_111"
)
{% endhighlight %}

{% highlight python %}
job.structure = pr.create_surface("Al", "fcc111", size=[1,1,4], vacuum=10)
job.structure.add_tag(selective_dynamics=(True, True, True))
{% endhighlight %}

{% highlight python %}
job.structure.plot3d()
{% endhighlight %}

{% highlight python %}
job.structure.selective_dynamics[
    range(len(job.structure)//2)
] = (False, False, False)
{% endhighlight %}