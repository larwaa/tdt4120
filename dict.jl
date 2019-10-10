function forloop(A::Dict{String, Dict{String, Int64}})::Int64
    result::Int64 = 0
    for i in 1:100000
        for (key::String, value::Dict{String, Int64}) in A
            result += value["A"]
        end
    end
    return result
end


function usingvalues(A::Dict{String, Dict{String, Int64}})::Int64
    result::Int64 = 0
    for i in 1:100000
        for value::Dict{String, Int64} in values(A)
            result += value["A"]
        end
    end
    return result
end

A = Dict{String, Dict{String, Int64}}("A" => Dict{String, Int64}("A" => 1), "B" => Dict{String, Int64}("A" => 1), "C" => Dict{String, Int64}("A" => 1), "D" => Dict{String, Int64}("A" => 1))

@time forloop(A)
@time usingvalues(A)
