function flexradix(A::Vector{String}, maxlength::Int64)::Vector{String}
	Base.sort!(A; alg=MergeSort)
end

@show flexradix(["Abc", "def"], 8)