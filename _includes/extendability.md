{% highlight python %}
# Edit me!
if lammps.status.finished:
    lammps.collect_output()
else:
    print(lammps.status)
{% endhighlight %}