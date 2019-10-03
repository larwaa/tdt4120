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

function countingsortletters(A::Array{String, 1}, position::Int64)::Array{String, 1}
    result = Array{String, 1}(undef, lastindex(A))
    cumulativecounter::Array{Int64, 1} = cumulativecount(A, position)

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

function getsublist(A::Array{String, 1}, maxlength)::Array{String, 1}
    # Assumes countinglengthsorted, so longest elements in the back. Thus, we work our way backwards.
    index = lastindex(A)
    for i in lastindex(A):-1:1
        if lastindex(A[i]) >= maxlength
            index = i
        end
    end
    return view(A, index:1:lastindex(A))
end

function reversecumulativecount(A::Array{String, 1})::Array{Int64, 1}
    maxv::Int64 = 0
    for value in A
        maxv = max(lastindex(value) + 1, maxv)
    end

    counter::Array{Int64, 1} = zeros(Int64, maxv)

    for value in A
        counter[lastindex(value) + 1] += 1
    end

    for i in lastindex(counter) - 1:-1:firstindex(counter)
        counter[i] += counter[i + 1]
    end
    return counter
end


function flexradix(A::Array{String, 1}, maxlength::Int64)::Array{String, 1}
    result::Array{String, 1} = countingsortlength(A)

    reversecumulativecounter = reversecumulativecount(A)

    for i in lastindex(reversecumulativecounter):-1:firstindex(reversecumulativecounter)
        position::Int64 = i - 1
        @show subarray = result[lastindex(result) + 1 - reversecumulativecounter[i]:end]
        if position > 0
            @show result[lastindex(result) + 1 - reversecumulativecounter[i]:end] = countingsortletters(subarray, position)
        end
    end
    return result
end

@show flexradix(["kobra", "alge", "agg", "kort", "hyblen"], 6)