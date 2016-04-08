"""Align matrix such that in each row the maximum has the position of the maximum of the mean row"""
function align_max{T <: Number}(S::Matrix{T})
    b = mean(S, 1)[:] # compute mean row
    _, max_b = findmax(b)
    ncols = size(S, 2)
    A = Array(eltype(S), size(S)) # output array
    for i = 1:size(A, 1)
        _, max_i = findmax(S[i, :])
        offset = max_b - max_i
        for j = 1:size(A, 2)
            k = (j+offset+ncols-1) % ncols + 1
            A[i,j] = S[i,k]
        end
    end
    return A
end

function remove_b(S::Matrix, nlast=200)
    baseline = mean(S[end-nlast:end, :], 1)
    _, rip_index = findmax(baseline)
    B = S .- baseline
end
