%% Part 3: Comparisons of Coding Techniques (Repetition Code)

%% Prerequisites
clc;
clear;
close all;

%% Define Essential Parameters
Nb = 1000;
N = 16;
K = 8;

%% Generating a bit sequence
% input = GenerateBits(Nb);
input = randi([0 1],1,Nb); % rem
input = [input zeros(1,mod(length(input),K))]; % rem

%% Encoding
encoded = [];
for i = 1:K:Nb
    encoded = [encoded encoder(input(i:i+K-1),N,K)];
end
EbNo = 0:10;
bit2symbol = 1 - 2 * encoded;
BER = zeros(1, length(EbNo));
p = zeros(1, length(EbNo));
for EbNoIndex = 1:length(EbNo)
    %% Add noise to samples
    trans = awgn(bit2symbol,EbNo(EbNoIndex));
    %% Compare bits before channel and after to get p (Probability of flipping)
    binSymbolsBeforeChannel = bit2symbol > 0;
    binSymbolsAfterChannel = trans > 0;
    % Get probability of flipping for this EbNo
    p(EbNoIndex) = sum(xor(binSymbolsBeforeChannel, binSymbolsAfterChannel))/length(trans);
    %% Decoding received symbols
    decoded = [];
    for i = 1:N:Nb*2
        decoded = [decoded decoder(trans(i:i+N-1),N,K)];
    end

    %% Calculating BER
    BER(EbNoIndex) = sum(decoded ~= input) / Nb;
end

%% Plot BER vs P
figure
plot(p, BER, 'linewidth', 2)
xlabel('Probability of flipping')
ylabel('BER')
grid on