__precompile__()

module IMS

export imssave, imsread

# module Plot
# using PyPlot
# function __init__()
#     info("Loading ims plot functions ...")
#     include(Pkg.dir("IMS", "src", "colormap.jl"))
#     register_ims_cmap()
# end
# end

include("utils.jl")
include("io.jl")
include("sgdebug.jl")
include("preprocess.jl")
include("peaks.jl")

end # module
