using PyPlot: ColorMap, register_cmap, imshow, imsave

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

"""Show a measurement matrix using an appropriate colormap"""
imsshow{T <: Number}(s::Matrix{T}; vmin=0, vmax=100) =
    imshow(s; cmap="ims", vmin=vmin, vmax=vmax, interpolation="none", origin="lower")

"""Like `imshow` but save an image using the `imsave` method of `PyPlot`"""
imssave{T <: Number}(s::Matrix{T}, f::AbstractString) =
    imsave(f, s; cmap="ims", vmin=0, vmax=100, origin="lower")
