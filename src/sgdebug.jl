using HDF5

"""Load debugging info from SGLTR"""
function sgdebug(fname::AbstractString)
    file = h5open(fname, "r")
    try
        k1h = a_read(fname["IMS"], "kernel1_h")
        k1v = a_read(fname["IMS"], "kernel1_v")
    finally
        close(file)
    end
end
