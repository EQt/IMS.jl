using PyPlot: ColorMap, register_cmap, imshow, imsave

"""Call this function before loading first call to imshow"""
function register_ims_cmap()
    r = [(0.0,  1.0, 1.0),
         (0.05, 0.0, 0.0),
         (0.1,  1.0, 1.0),
         (0.2,  1.0, 1.0),
         (0.6,  1.0, 1.0),
         (1.0,  1.0, 1.0)]

    g = [(0.0,  1.0, 1.0),
         (0.05, 0.0, 0.0),
         (0.1,  0.0, 0.0),
         (0.2,  0.0, 0.0),
         (0.6,  1.0, 1.0),
         (1.0,  1.0, 1.0)]

    b = [(0.0,  1.0, 1.0),
         (0.05, 1.0, 1.0),
         (0.1,  1.0, 1.0),
         (0.2,  0.0, 0.0),
         (0.6,  0.0, 0.0),
         (1.0,  0.0, 0.0)]

    cm = ColorMap("ims", r, g, b)
    register_cmap("ims", cm)
end

__init__() = register_ims_cmap()


"""Show a measurement matrix using an appropriate colormap"""
imsshow{T <: Number}(s::Matrix{T}; vmin=0, vmax=100) =
    imshow(s; cmap="ims", vmin=vmin, vmax=vmax, interpolation="none", origin="lower")

"""Like `imshow` but save an image using the `imsave` method of `PyPlot`"""

lsimssave{T <: Number}(s::Matrix{T}, f::AbstractString; vmin=0, vmax=100) =
    imsave(f, s; cmap="ims", vmin=vmin, vmax=vmax, origin="lower")
