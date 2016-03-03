using HDF5

"""Read an IMS measurement file (in all available formats)"""
function imsread(file_name::AbstractString; normalize=true, asfloat=true)
    isfile(file_name) || error(@sprintf("`%s` is not a readable file", file_name))
    ims = ishdf5(file_name) ? imsread_hdf5(file_name) : imsread_csv(file_name)
    if normalize
        if length(ims["R"]) != size(ims["S"], 1)
            ims["S"] = ims["S"]'
        end
        if mean(ims["S"]) < 0
            ims["S"] = -ims["S"]
        end
    end
    if asfloat
        ims["S"] = map(Float64, ims["S"])
    end
    return ims
end

"""CSV parser"""
function imsread_csv(file_name::AbstractString)
    data = readcsv(file_name, Float64, skipstart=132, use_mmap=true)
    S = data[:,3:end]'
    D = data[:,2]
    T = data[:,1]

    tR = split(readline(file_name, 131), ",")
    @assert startswith(tR[1], "\\")
    @asserteq strip(tR[2]) "tR"
    R = float(tR[3:end])
    @asserteq size(S,1) length(R)

    return Dict(@qvs S D T R)
end


"""HDF5 parser"""
function imsread_hdf5(h5_fname::AbstractString)
    h5open(h5_fname, "r") do file
        if HDF5.exists(file, "IMS")
            file = g_open(file, "IMS")
        end
        return [k => read(file, k) for k in names(file)]
    end
end
