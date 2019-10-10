#=
test:
- Julia version: 1.2.0
- Author: larswaage
- Date: 2019-10-10
=#

function brokendnasearch(root, dna::String, i::Int64=1)::Int64
    @show dnamem
    if haskey(dnamem, dna)
        return dnamem[dna]
    end

    if root == nothing
        return 0
    elseif lastindex(dna) < i # Sjekk om DNA er den tomme strengen
        dnamem[dna] = root.count
		return root.count
	elseif dna[i] == '?' # Sjekk om det er den vilkårlige characteren
        sequences::Int64 = 0 # lag en teller
        for (key::Char, children) in root.children # iterer gjennom alle keys og nodes
            sequences += brokendnasearch(children, dna, i + 1)
        end
        dnamem[dna] = sequences
        return sequences
    else
        return brokendnasearch(get(root.children, dna[i], nothing), dna, i + 1)
    end
    return 0
end