%% Generate bits to be tarnsmitted through channel
Bits  = [0 0 1 0 1 1 0 1 0 1];

%% Encode Bits
RegLength = 3;             % Register length
GenPoly = [1 1 1; 0 1 1];      % Generator Polynomial [7; 3]

EncodedBits = convEncode(Bits, RegLength, GenPoly);

%% Decode
myTrellis = poly2trellis(RegLength, [7 3]);
decodedBits = viterbiAlgorithm(EncodedBits, RegLength, [7 3]);

%% Compare sent with received
sum(abs(Bits - decodedBits))

