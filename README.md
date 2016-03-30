# Ion Mobility Spectrometry

[![Build Status](https://travis-ci.org/EQt/IMS.jl.svg?branch=master)](https://travis-ci.org/EQt/IMS.jl)

These are some utility functions to be used with Julia to process
Ion Mobility Spectrometry (IMS) measurement files.

Author: [Elias Kuthe](http://genomeinformatics.uni-due.de/people/elias-kuthe/)

## HDF5 File Format
The measurements in HDF5 file format usually contain the following data objects

- `S` the measurement matrix, often an `Int16`
- `R` the retention times (in seconds) of the corresponding rows of `S`
- `D` the drift times (in milliseconds) of the corresponding columns of `S`
- `T` the `1/K0` values (normalized drift times) of the corresponding columns of `S`

Sometimes, the `S` matrix is transposed, or contains negative values.
