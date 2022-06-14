Developing-with-MPI-and-OpenMP
==================

Introductory course on developing MPI and OpenMP application developed by Rebecca Hartman-Baker
and the Pawsey Supercomputing Centre.

To run interactively in a reservation at NERSC, use the following command:

```
salloc -A ntrainN -N 1 -t 00:30:00 --reservation=res_name
```

To run via a batch script, use the sbatch command:
```
sbatch runall_batch.sh
```

Substituting the proper training project for `ntrainN` and proper reservation name for `res_name`, and we suggest to run part of the exercises from runall.sh at a time.
