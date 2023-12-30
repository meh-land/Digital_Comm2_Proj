%% Part 3: Comparisons of Coding Techniques (Repetition Code)

%% Prerequisites
clc;
clear;
close all;

%% Define Essential Parameters
% Total number of bits
N_bits = 10000; 

% Channel parameter (probability of bit flipping)
p      = 0.2;   

%% Generate a bit sequence
bit_seq = GenerateBits(N_bits);
