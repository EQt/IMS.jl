using IMS
using Base.Test

const URL     = "http://ls11-www.cs.tu-dortmund.de/people/daddari/peax/dataset-peax-anonymized-measurements.zip"
const IMS_ZIP = "data/measurements.zip"
const IMS_13  = "data/13.csv"

cd(dirname(@__FILE__)) do
    isdir(dirname(IMS_ZIP)) || mkdir(dirname(IMS_ZIP))
    isfile(IMS_ZIP) || download(URL, IMS_ZIP)
    if !isfile(IMS_13)
        include("need_zip.jl")
        zf = ZipFile.Reader(IMS_ZIP)
        i = findfirst(f -> f.name == basename(IMS_13), zf.files)
        f = zf.files[i]
        s = readall(f)
        s = replace(s, "\n\n", "\n")
        open(IMS_13, "w") do out
            write(out, s)
        end
    end

    ims = readims(IMS_13)
end
