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


"""Return value of `vals` which is closest to `x`"""
function closest(vals, x)
    _, index = findmin([abs(v - x) for v in vals])
    return vals[index]
end


"""Fits a linear line through the values in `enumerate(ys)` and returns the maximum absolute deviation"""
function lindev{T<:Number}(ys::Vector{T})
    a, b = linreg(collect(1.0:length(ys)), ys)
    return maxabs([y - (a + b*i) for (i, y) in enumerate(ys)])
end
