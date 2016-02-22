using HDF5

"""Return a dictionary containing the variables `vars` together with their values"""
macro vardict(vars...)
    :(Dict([ (string(v), eval(v)) for v in $vars]))
end


"""Load debugging info from SGLTR"""
function sgdebug(fname::AbstractString)
    fid = h5open(fname, "r")
    try
        k1h = a_read(fid["IMS"], "kernel1_h")
        k1v = a_read(fid["IMS"], "kernel1_v")
        k2h = a_read(fid["IMS"], "kernel2_h")
        k2v = a_read(fid["IMS"], "kernel2_v")
        S = read(fid, "IMS/raw")'
        L = read(fid, "IMS/laplace")'

        T1 = conv2(k1v, k1h, S)
        T2 = conv2(k2v, k2h, S)
        T = T1 + T2

        @vardict k1h k1v k2h k2v S L
    finally
        close(fid)
    end
end


"""Clip to interesting part of the measurement"""
interesing(S) = S[1:400, 760:1250]
