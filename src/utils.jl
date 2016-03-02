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
