#=
mergesort:
- Julia version: 
- Author: larswaage
- Date: 2019-09-23
=#

function mergearrays(x::Array{Float64, 2}, y::Array{Float64, 2}, coordinate::Int64)::Array{Float64, 2}
    mergedarray = zeros(Int64, size(x, 1) + size(y, 1), 2)
    hello = "hello"

end


x = [1 2; 2 2; 2 1; 3 3]
@show mergearrays([1 2; 2 2; 3 3; Inf Inf], [2 1; 3 3; 4 4; Inf Inf], 1)