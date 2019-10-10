function buildtree(dnasequences)
    root = Node()

    root.count = length(dnasequences)

    for dnasequence in dnasequences
        addchildren(root, dnasequence)
    end
    return root
end


function addchildren(root, dnasequence)
    if dnasequence != ""
        get(root.children, dnasequence[0], Node()).count += 1
        if lastindex(dnasequence >= 2)
            addchildren(root.children[dnasequence[0]], dnasequence[2:end])
        end
    end
end