using HDF5

"""Parse IMS measurement"""
function imsread(file_name::AbstractString)
    isfile(file_name) || error(@sprintf("`%s` is not a readable file", file_name))
    ishdf5(file_name) && return imsread_hdf5(file_name)
    return imsread_csv(file_name)
end

"""CSV parser"""
function imsread_csv(file_name::AbstractString)
    data = readcsv(file_name, Float64, skipstart=132, use_mmap=true)
    S = data[:,3:end]
    return S'
end


"""HDF5 parser"""
function imsread_hdf5(h5_fname::AbstractString)
    h5open(h5_fname, "r") do file
        if HDF5.exists(file, "/IMS/S")
            info("IMS")
            S = read(file, "/IMS/S")
            return S
        else
            S = read(file, "S")
            return S
        end
    end
end

