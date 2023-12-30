clear all
%% Generate bits to be tarnsmitted through channel
Bits  = GenerateBits(1e5);
Nbits = length(Bits);

%% Encode Bits
RegLength = 3;             % Register length
GenPoly = [1 1 1; 0 1 1];      % Generator Polynomial [7; 3]
% My Encoder
myEncodedBits = convEncode(Bits, RegLength, GenPoly);

% Built-in encoder
trellis = poly2trellis(RegLength, [7, 3]);
defaultEncodedBits = convenc(Bits, trellis);

% Compare the two encoders
encodingDiff = sum(xor(defaultEncodedBits, myEncodedBits))

%% Decoding
% My decoder
myDecodedBits = viterbiDecode(defaultEncodedBits);

% Built-in decoder
defaultDecodedBits = vitdec(defaultEncodedBits,trellis,Nbits,'trunc', 'hard');


% Compare the two decoders
decodingDiff = sum(xor(defaultDecodedBits, myDecodedBits))

