Developing-with-MPI-and-OpenMP
==================

Introductory course on developing MPI and OpenMP application developed by Rebecca Hartman-Baker
and the Pawsey Supercomputing Centre.

To run interactively in a reservation at NERSC, use the following command:

```
salloc -A proj_name -N 1 -t 00:30:00 --reservation=res_name
```
where `proj_name` is your NERSC project name (such as `trn012`), and `res_name` is the compute nodes reservation name (such as `crash_course`).

To run via a batch script, use the sbatch command:
```
sbatch runall_batch.sh
```

Substituting the proper training project for `proj_name` and proper reservation name for `res_name`, and we suggest to run part of the exercises from runall.sh at a time.
