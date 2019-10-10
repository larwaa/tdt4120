using BenchmarkTools


function reverseandlimit(array::Array{Int64, 1}, maxnumber::Int64)::SubArray{Int64, 1}
    @inbounds for (index::Int64, value::Int64) in enumerate(array)
         array[index] = min(value, maxnumber)
    end
    return view(array, lastindex(array):-1:firstindex(array))
end

function reverseandlimit2(array, maxnumber)
    reversedandlimited = []
	while length(array) > 0
        poppednumber = pop!(array)
        if poppednumber <= maxnumber
            push!(reversedandlimited, poppednumber)
        else
            push!(reversedandlimited, maxnumber)
        end
    end
    return reversedandlimited
end

@btime reverseandlimit([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], 10)
@btime reverseandlimit2([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], 10)
