clear all
%% Generate bits to be tarnsmitted through channel
Bits  = GenerateBits(5);
Nbits = length(Bits);
P = 0.02;
BER = ones(1, length(P));

%% Encode Bits
RegLength = 3;             % Register length
GenPoly = [1 1 1; 0 1 1];      % Generator Polynomial [7; 3]

EncodedBits = convEncode(Bits, RegLength, GenPoly);

%% BSC and decoding
for i = 1:length(P)
    % This is an independent BSC so fs is not relevant so I used fs = 1
%     recBits = BSC(EncodedBits, 1, P(i)); 
    recBits = xor(EncodedBits, [zeros(1, 2*Nbits -1) 1]) + 0; 
    % My decoder
    myDecodedBits = viterbiDecode(recBits);
    % Calculate BER
    BER(i) = sum(abs(Bits - myDecodedBits))/ Nbits;
end

% Plot BER vs P
figure
plot(P, BER, 'linewidth', 2)
xlabel('Probability of bit flipping')
ylabel('BER')
title('BER vs P')
grid on
