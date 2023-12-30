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
EbNo = 4;
bit2symbol = 1 - 2 * encoded; 

%% Decoding the received samples
trans = awgn(bit2symbol,EbNo);
decoded = [];
for i = 1:N:Nb*2
    decoded = [decoded decoder(trans(i:i+N-1),N,K)];
end

%% Calculating BER
BER = sum(decoded ~= input) / Nb
