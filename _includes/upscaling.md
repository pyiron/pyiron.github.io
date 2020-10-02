```python
table = pr.create_table()  # Create analysis object 
table.add.get_energy_tot  # Define analysis functions 
table.add.get_volume  # get the volume and total energy
table.add["job_type"] = lambda job: job.__name__  # Add custom analysis function
table.run()  # Execute the analysis 
print(table.get_dataframe())  # Results are summarized in DataFrame
```