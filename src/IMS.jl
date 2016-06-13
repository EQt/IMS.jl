__precompile__()

module IMS

export imssave, imsshow, imsread

if isdefined(:PyPlot)
    include("colormap.jl")
end

include("utils.jl")
include("io.jl")
include("sgdebug.jl")
include("preprocess.jl")
include("peaks.jl")

end # module
