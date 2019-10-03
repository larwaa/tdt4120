#=
countingsortlength:
- Julia version: 1.2.0
- Author: larswaage
- Date: 2019-10-02
=#

function countingsortlength(A::Array{String, 1})::Array{String, 1}
    counter::Array{Int64, 1} = cumulativecount(A)
    result::Array{String, 1} = Array{String, 1}(undef, counter[end])

    for value in view(A, lastindex(A):-1:firstindex(A))
        index::Int64 = counter[lastindex(value) + 1]
        result[index] = value
        counter[lastindex(value) + 1] -= 1
    end
    return result
end

function cumulativecount(A::Array{String, 1})::Array{Int64, 1}
    maxv::Int64 = 0
    for value in A
        maxv = max(lastindex(value) + 1, maxv)
    end

    counter::Array{Int64, 1} = zeros(Int64, maxv)

    for value in A
        counter[lastindex(value) + 1] += 1
    end

    for i in 2:lastindex(counter)
        counter[i] += counter[i - 1]
    end
    return counter
end




@show countingsortlength(["", "aa", "aaaa", "ccc", "bbbb", "aa", "aaaaaaa", "cccccccccccccc"])