function bits = edges2Bits(edgesMatrix)
    edgesNum = size(edgesMatrix);
    edgesNum = edgesNum(1);
    bits = zeros(1, edgesNum);
    transitionMem = zeros(4,4);
    transitionMem(:, [2, 4]) = 1;
    for i = 1:edgesNum
        bits(i) = transitionMem(edgesMatrix(i, 1), edgesMatrix(i, 2));
    end
end