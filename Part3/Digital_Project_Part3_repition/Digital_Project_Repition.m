%% Part 3: Comparisons of Coding Techniques (Repetition Code)

%% Prerequisites
clc;
clear;
close all;

%% Define Essential Parameters
% Total number of bits
N_bits = 5; 

% Channel parameter (probability of bit flipping)
p = 0:0.05:0.5;   

% Sampling frequency
fs = 10;

% BER
BER_BSC = [];
BER_BEC = [];

%% Generate a bit sequence
bit_seq = GenerateBits(N_bits);

%% Generate Samples
sample_seq = GenerateSamples(bit_seq,fs);

%% Encoding && Decoding (BSC)
for i=1:1:10
    % Sampled binary sequence pass through BSC @ different P's
    rec_sample_seq = BSC(sample_seq,fs,p(i));
    % Decoding the received samples @ different P's
    rec_bit_seq = DecodeBitsFromSamples(rec_sample_seq,fs);
    % Calculating BER
    temp = ComputeBER(bit_seq,rec_bit_seq);
    BER_BSC = [BER_BSC temp];
end
%% Encoding && Decoding (BEC)
for i=1:1:10
    % Sampled binary sequence pass through BSC @ different P's
    rec_sample_seq = BEC(sample_seq,fs,p(i));
    % Decoding the received samples @ different P's
    rec_bit_seq = DecodeBitsFromSamples(rec_sample_seq,fs);
    % Calculating BER
    temp = ComputeBER(bit_seq,rec_bit_seq);
    BER_BEC = [BER_BEC temp];
end
