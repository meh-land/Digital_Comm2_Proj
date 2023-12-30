%% Part 3: Comparisons of Coding Techniques (Repetition Code)

%% Prerequisites
clc;
clear;
close all;

%% Define Essential Parameters
% Total number of bits
N_bits = 5; 

% Channel parameter (probability of bit flipping)
p = 0:0.1:0.5;   

% Sampling frequency
fs = 10;

% BER
BER = [];

%% Generate a bit sequence
bit_seq = GenerateBits(N_bits);

%% Generate Samples
sample_seq = GenerateSamples(bit_seq,fs);

%% Encoding && Decoding
for i=1:1:5
    % Sampled binary sequence pass through BSC @ different P's
    rec_sample_seq = BSC(sample_seq,fs,p(i));
    % Decoding the received samples @ different P's
    rec_bit_seq = DecodeBitsFromSamples(rec_sample_seq,fs);
    % Calculating BER
    temp = ComputeBER(bit_seq,rec_bit_seq);
    BER = [BER temp];
end
