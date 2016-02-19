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

imsshow(s::Matrix{Float64}) =
    imshow(s; cmap="ims", vmin=0, vmax=100, interpolation="none", origin="lower")

imssave(s::Matrix{Float64}, f::AbstractString) =
    imsave(f, s; cmap="ims", vmin=0, vmax=100, origin="lower")
