import Base.readline

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
