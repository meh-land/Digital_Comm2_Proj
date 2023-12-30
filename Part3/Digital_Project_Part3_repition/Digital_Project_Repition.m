%% Part 3: Comparisons of Coding Techniques (Repetition Code)

%% Prerequisites
clc;
clear;
close all;

%% Define Essential Parameters
% Total number of bits
N_bits = 50; 

% Channel parameter (probability of bit flipping)
p = 0.2;   

% Sampling frequency
fs = 10;

%% Generate a bit sequence
bit_seq = GenerateBits(N_bits)

%% Generate Samples
sample_seq = GenerateSamples(bit_seq,fs);

%% Sampled binary sequence pass through BSC
rec_sample_seq  = BSC(sample_seq,fs,p);

%% Decoding the received samples
rec_bit_seq = DecodeBitsFromSamples(rec_sample_seq,fs)




