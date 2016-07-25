__precompile__()

module IMS

export imssave, imsread

function __init__()
    if isdefined(:PyPlot)
        info("Loading ims plot functions ...")
        include(Pkg.dir("IMS", "src", "colormap.jl"))
        register_ims_cmap()
    else
        info("No plotting supported")
    end
end


include("utils.jl")
include("io.jl")
include("sgdebug.jl")
include("preprocess.jl")
include("peaks.jl")

end # module
