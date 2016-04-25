__precompile__()

module IMS

export imssave, imsshow, imsread

include("colormap.jl")
include("utils.jl")
include("io.jl")
include("sgdebug.jl")
include("preprocess.jl")
include("peaks.jl")

end # module
