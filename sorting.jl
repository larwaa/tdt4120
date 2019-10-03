function countingletters(A::Array{String, 1}, position::Int64)::Array{String, 1}
    @show result = Array{String, 1}(undef, lastindex(A))
    @show cumulativecounter::Array{Int64, 1} = cumulativecount(A, position)

    for value in view(A, lastindex(A):-1:firstindex(A))
        index::Int64 = cumulativecounter[chartodigit(value[position])]
        result[index] = value
        cumulativecounter[chartodigit(value[position])] -= 1
    end
    return result
end

function cumulativecount(A::Array{String, 1}, position::Int64)::Array{Int64, 1}
    counter::Array{Int64, 1} = zeros(Int64, 27)

    @inbounds for element in A
        counter[chartodigit(element[position])] += 1
    end

    @inbounds for i in 2:lastindex(counter)
        counter[i] += counter[i - 1]
    end
    return counter
end


function chartodigit(character::Char)::Int64
    return character - '`'
end

A = ["hello", "how", "are", "you"]
@show countingletters(A, 2)

