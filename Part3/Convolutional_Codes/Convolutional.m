%% Generate bits to be tarnsmitted through channel
Bits  = GenerateBits(1e5);

%% Encode Bits
RegLength = 3;             % Register length
GenPoly = [1 1 1; 0 1 1];      % Generator Polynomial [7; 3]

EncodedBits = convEncode(Bits, RegLength, GenPoly);

%% Decode
% Built-in decoder
myTrellis = poly2trellis(RegLength, [7 3]);
defDecodedBits = vitdec(EncodedBits,myTrellis,length(Bits),'trunc','hard');

% My decoder
myDecodedBits = viterbiDecode(EncodedBits);


%% Compare Built-in with my decoder
sum(abs(myDecodedBits - defDecodedBits))

