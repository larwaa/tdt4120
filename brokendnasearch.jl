function brokendnasearch(root, dna::String, i::Int64=1)::Int64
    if root == nothing # There are no matches of the DNA string if root is set to nothing
        return 0
    elseif lastindex(dna) < i # check if current index is out of bounds
		return root.count # reached the end of the sequence, return the count
	elseif dna[i] == '?' # check if the relevant character is '?'
        sequences::Int64 = 0 # counter for number of sequences
        for (key::Char, children) in root.children # iterate through all children
            sequences += brokendnasearch(children, dna, i + 1) # add the sequence count of all children to the total
        end
        return sequences # return the total sequences that match
	else
		# if the relevant character matches any of the children to the current root, we move recursively down.
		# otherwise set the root to nothing.
        return brokendnasearch(get(root.children, dna[i], nothing), dna, i + 1) 
    end
end