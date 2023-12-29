function decodedBits = viterbiAlgorithm(receivedBits, constraintLength, generatorPolynomials)
    % receivedBits: The received sequence of bits
    % constraintLength: Constraint length of the convolutional code
    % generatorPolynomials: Generator polynomials in octal representation

    % Define the trellis based on the provided parameters
    trellis = defineTrellis(constraintLength, generatorPolynomials);

    % Initialize matrices
    numStates = 2^constraintLength;
    numInputs = 2;
    pathMetrics = zeros(numStates, 1);
    survivorPaths = zeros(numStates, length(receivedBits));

    % Viterbi decoding
    for i = 1:length(receivedBits)
        % Compute branch metrics
        branchMetrics = computeBranchMetrics(pathMetrics, trellis, receivedBits(i));

        % Update path metrics
        [pathMetrics, survivorPaths] = updatePathMetrics(pathMetrics, branchMetrics, survivorPaths, numInputs);
    end

    % Traceback to find the most likely path
    decodedBits = traceback(survivorPaths, pathMetrics, trellis);
end

function trellis = defineTrellis(constraintLength, generatorPolynomials)
    % Define the trellis structure based on the provided parameters

    trellis.numInputSymbols = constraintLength + 1;
    trellis.numOutputSymbols = 2;

    trellis.nextStates = zeros(2^constraintLength, 2);
    trellis.outputs = zeros(2^constraintLength, 2);

    for currentState = 0:(2^constraintLength - 1)
        for inputBit = 0:1
            nextState = bitshift(currentState, 1) + inputBit;
            outputBits = rem(generatorPolynomials * [bitget(currentState, constraintLength:-1:1), inputBit]', 2);

            trellis.nextStates(currentState + 1, inputBit + 1) = nextState + 1;
            trellis.outputs(currentState + 1, inputBit + 1) = outputBits(2) * 2 + outputBits(1) + 1;
        end
    end
end


function branchMetrics = computeBranchMetrics(pathMetrics, trellis, receivedBit)
    % Compute branch metrics based on received bit and current pathMetrics

    numStates = 2^(trellis.numInputSymbols - 1);
    numInputs = 2;

    branchMetrics = zeros(numStates, numInputs);

    for currentState = 1:numStates
        for inputBit = 1:numInputs
            nextState = trellis.nextStates(currentState, inputBit);
            outputBit = trellis.outputs(currentState, inputBit);

            % Compute Hamming distance as the branch metric
            branchMetrics(nextState, inputBit) = pathMetrics(currentState) + ...
                hammingDistance(outputBit, receivedBit);
        end
    end
end

function distance = hammingDistance(bit1, bit2)
    % Compute Hamming distance between two bits
    distance = sum(bitget(bitxor(bit1, bit2), 1:8));
end

function [updatedPathMetrics, updatedSurvivorPaths] = updatePathMetrics(pathMetrics, branchMetrics, survivorPaths, numInputs)
    % Update path metrics and survivor paths based on branch metrics

    numStates = size(branchMetrics, 1);
    updatedPathMetrics = Inf(numStates, 1);
    updatedSurvivorPaths = zeros(numStates, size(survivorPaths, 2));

    for currentState = 1:numStates
        for inputBit = 1:numInputs
            nextState = currentState + 1;

            metric = pathMetrics(currentState) + branchMetrics(nextState, inputBit);

            % Update path metric and survivor path if the new metric is better
            if metric < updatedPathMetrics(nextState)
                updatedPathMetrics(nextState) = metric;
                updatedSurvivorPaths(nextState, :) = [survivorPaths(currentState, 2:end), inputBit];
            end
        end
    end
end

function decodedBits = traceback(survivorPaths, pathMetrics, trellis)
    % Traceback to find the most likely path and decode the bits

    [~, finalState] = min(pathMetrics);

    decodedBits = zeros(1, size(survivorPaths, 2));

    currentState = finalState - 1;
    for i = size(survivorPaths, 2):-1:1
        decodedBits(i) = survivorPaths(currentState + 1, end);
        currentState = trellis.nextStates(currentState + 1, decodedBits(i)) - 1;
    end
end
