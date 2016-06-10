using DataFrames

"""Print in the format we used in the project group"""
function write_peaks(path::Union{AbstractString,IO}, df::DataFrame)
    d = copy(df)
    if !(:name in names(d))
        d[:name] = [symbol(@sprintf("P%d", i)) for i=1:size(d, 1)]
        d = d[circshift(names(d), 1)]
    end
    # d[:t] .*= 100
    sort!(d, cols=order(:r))
    if isa(path, IO)
        printtable(path, d, separator='\t', header=true)
    else
        writetable(path, d, separator='\t', header=true)
    end
end


"""Read a peak list and return a DataFrame"""
function read_peaks(path::AbstractString)
    readtable(path, separator='\t')
end

export read_peaks, write_peaks

