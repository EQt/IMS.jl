import Base.readline


macro asserteq(a,b)
    msg = "$a != $b"
    :($a == $b || throw(AssertionError("$($msg): $($a), $($b)")))
end


macro qv(v)
    s = string(v)
    :(($s, $v))
end


"""Return a dictionary containing the variables `vs` together with their values"""
macro qvs(vs...)
    v = (vs...)[1]
    if length(vs) == 1
        s = string(v)
        :(@qv $v)
    else
        :([@qv($v); @qvs($((vs...)[2:end]...))])
    end
end


"""Read line number `line` in file `filename`"""
function readline(filename::AbstractString, line::Int)
    open(filename) do io
        s = bytestring(Mmap.mmap(io))
        line <= 0 && error("negative line number")
        start = 0
        stop  = findfirst(s, '\n')
        i = 1
        while (i == 1 || start > 0) && i < line 
            start = stop
            stop = findnext(s, '\n', stop+1)
            i += 1
        end
        line == i && return copy(s[start+1:stop-1])
        error("`$filename` only has $(i-1) lines")
    end
end


"""Return index of `vals` which is closest to `x`"""
function closest_index(vals, x)
    _, index = findmin([abs(v - x) for v in vals])
    return index
end
closest(vals, x) = vals[closest_index(vals, x)]

"""Fits a linear line through the values in `enumerate(ys)` and returns the maximum absolute deviation"""
lindev{T<:Number}(ys::Vector{T}) = maxabs(lindev_vec(ys))

"""Return deviation vector from a linear fitted line"""
function lindev_vec{T<:Number}(ys::Vector{T})
    a, b = linreg(collect(1.0:length(ys)), ys)
    return [y - (a + b*i) for (i, y) in enumerate(ys)]
end


"""Resample measurement S at retention times R such that the new matrix has size n*size(S,2)"""
function resample(S::Matrix, R::Vector, n::Int)
    @assert issorted(R)
    M = zeros(n, size(S, 2))
    Rmin, Rmax = R[1], R[size(S, 1)]
    for (i, t) = enumerate(linspace(Rmin, Rmax, n))
        i0 = findlast(R .<= t)
        i1 = findfirst(R .>= t)
        a = R[i1] - R[i0] <= 1e-10 ? 1.0 : (t - R[i1]) / (R[i0] - R[i1])
        for j = 1:size(S, 2)
            M[i,j] = a*S[i0, j] + (1 - a)*S[i1, j]
        end
    end
    return M
end

"""Uniform resampling"""
resample(S, n::Int) = resample(S, collect(1:n), n)

"""Resampling according to a function"""
resample(S::Matrix, f::Function, n::Integer) = resample(S, [f(i) for i=1:n], n)


"""Compute the forward difference of a vector"""
function forward_diff{T}(x::Vector{T})
    return [x[i] - x[i-1] for i = 2:length(x)]
end


"""Plot a histogramm of an array"""
ploth(x; bins=300) = PyPlot.gca()[:hist](x[:], bins=bins)
