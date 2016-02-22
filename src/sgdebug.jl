using HDF5

"""Return a dictionary containing the variables `vars` together with their values"""
macro qv(v)
    s = string(v)
    :(($s, $v))
end


macro qvs(vs...)
    v = (vs...)[1]
    if length(vs) == 1
        s = string(v)
        :(@qv $v)
    else
        :([@qv($v); @qvs($((vs...)[2:end]...))])
    end
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

        Dict(@qvs k1h k1v k2h k2v S L)
    catch
        rethrow()
    finally
        close(fid)
    end
end


"""Generate SGLTR debug file"""
function sgltr_debug(fname::AbstractString)
    dname = fname * ".debug"
    peaks = readall(pipeline(`sgltr $fname -d $dname`, stderr=DevNull))
    readdlm(IOBuffer(peaks), '\t'; header=true)
end


"""Clip to interesting part of the measurement"""
interesing(S) = S[1:400, 760:1250]
