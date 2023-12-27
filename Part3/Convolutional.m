% Generate bits to be tarnsmitted through channel
Bits = GenerateBits(10);

% Encode Bits
RegLength = 3;             % Register length
GenPoly = [1 1 1; 0 1 1; 1 0 1];      % Generator Polynomial [7; 3; 5]

EncodedBits = convEncode(Bits, RegLength, GenPoly);

