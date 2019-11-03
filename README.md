# Homework 6

Complete a group analysis on the FFL data using the cluster.

- Use the first level results you have calculated for each subject
- Calculate a one sample t-test for each of the three lower level contrasts using FLAME mixed effects (`--runmode=flame`). Put your scripts in `flame.sh` and `sbatch_flame.sh`
- Use cluster correction with a height threshold of $Z>2.3$ and cluster threshold $p < .05$
- For each contrast, create a table that lists the following information for each significant cluster (a template to fill out is in `results.md`):
	- Anatomical label and hemisphere
	- Cluster size in voxels
	- Peak Z value
	- Location of the peak Z value in mm coordinates
- Create one or more images that show your results

Submit your homework on GitHub by forking this repository, cloning your fork, committing your scripts, table, and images, pushing your clone, and creating a pull request.

Report any problems to #homework
