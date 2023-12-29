%% Generate bits to be tarnsmitted through channel
Bits  = [0 1 0 1 1];

%% Encode Bits
RegLength = 3;             % Register length
GenPoly = [1 1 1; 0 1 1];      % Generator Polynomial [7; 3]

EncodedBits = convEncode(Bits, RegLength, GenPoly);

%% Base Trellis: Struct that contains a matrix of Nodes and an array of
% edges
baseTrellisSize = [4 2];
% Start a new struct Node
baseNode.state = [0 0];
% Start a new struct Edge
baseEdge.input = 0;
baseEdge.output = [0 0];
% Relation between nodes and edges
baseEdge.startNode = baseNode;
baseEdge.endNode = baseNode;

baseNode.inEdge = baseEdge;
baseNode.outEdge = baseEdge;
% Initialize states of each node
for r = 1:baseTrellisSize(1)
    for c = 1:baseTrellisSize(2)
        baseTrellis(r, c, 1).state = [~mod(r, 2) r>2] + 0;
    end
end
% Initialize Edges
outputs(1,2, [1,2]) = [0 0];
outputs(2,2, [1,2]) = [1 1];
outputs(3,2, [1,2]) = [1 1];
outputs(4,2, [1,2]) = [0 0];
outputs(1,3, [1,2]) = [1 0];
outputs(2,3, [1,2]) = [0 1];
outputs(3,3, [1,2]) = [0 1];
outputs(4,3, [1,2]) = [1 0];
for r = 1:baseTrellisSize(1)
    for e = 2:3
    baseTrellis(r, 1, e).input = e - 2;
    baseTrellis(r, 1, e).output = outputs(r, e, [1, 2]);
    end
end


