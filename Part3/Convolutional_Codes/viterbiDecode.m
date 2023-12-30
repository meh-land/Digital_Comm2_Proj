function decodedBits = viterbiDecode(encodedBits)
    reshapedRecBits = reshape(encodedBits, 2, [])';
    N = -1* ones(4, length(encodedBits)/2 +1);
    N = N + 1i*N;
    N(1,1) = 0;
    s = size(N);
    % All elements in this matrix belong to the set {0, 1, 2}, where the
    % element equals 0 if it has no predecessor, equals 1 if the dominant value
    % is that of the first predecessor, equals 1 if the dominant value is that of the 
    % second predecessor
    predMatrix = zeros(s(1), s(2));
    for c = 1:s(2) -1
        for r = 1:s(1)
            if c == 1 && r > 1
                continue
            end
            if c == 2 && r > 2
                continue
            end
            currPivot = abs(N(r, c));
            % calculate successor1
            succ1Row = getSuccessorRow(r, 1);
            succ1 = N(succ1Row, c+1);
            transitionNominalValue = getTransitionValue(r, succ1Row);
            currRecBits = reshapedRecBits(c, :);
            % Get hamming distance between nominal bits and received bits
            hammingDistance = sum(abs(transitionNominalValue - currRecBits));
            % Get the path metric of this tarnsition
            newSuccValue = hammingDistance + abs(currPivot);
            if real(succ1) == -1  % This is the first time this node is accessed
                % Set the transitionValue to be the real component
                N(succ1Row, c+1) = newSuccValue  - 1i;
            else
                % Set the transitionValue to be the imaginary component
                N(succ1Row, c+1) = real(N(succ1Row, c+1)) + newSuccValue * 1i;
            end

            % calculate successor2
            succ2Row = getSuccessorRow(r, 2);
            succ2 = N(succ2Row, c+1);
            transitionNominalValue = getTransitionValue(r, succ2Row);
            currRecBits = reshapedRecBits(c, :);
            % Get hamming distance between nominal bits and received bits
            hammingDistance = sum(abs(transitionNominalValue - currRecBits));
            % Get the path metric of this tarnsition
            newSuccValue = hammingDistance + abs(currPivot);
            if real(succ2) == -1  % This is the first time this node is accessed
                % Set the transitionValue to be the real component
                N(succ2Row, c+1) = newSuccValue - 1i;
            else
                % Set the transitionValue to be the imaginary component
                N(succ2Row, c+1) = real(N(succ2Row, c+1)) + newSuccValue * 1i;
            end
        end
        % Tidy up the current successor column because it will be the pivot of
        % the next iteration
        c2 = c+1;
        for r2 = 1:s(1)
            [predMatrix(r2, c2), N(r2, c2)] = getDominant(N(r2, c2));
        end
    end

    % Find the row of the element with the least path metric in the last column
    minPMRow = find(abs(N(:, s(2))) == min(abs(N(:, s(2)))));
    % In case there are more than one element with the same PM
    minPMRow = minPMRow(1); 
    % matrix to store edges
    edges = [];
    currElemR = minPMRow;
    currElemC = s(2);
    % Calculate the path from beggining to optimum node
    while currElemC ~= 1
        currPredRow = getPredecessorRow(currElemR, predMatrix(currElemR, currElemC));
        currEdge = [currPredRow currElemR];
        edges = [currEdge; edges];
        currElemR = currPredRow;
        currElemC = currElemC -1;
    end

    decodedBits = edges2Bits(edges);
end