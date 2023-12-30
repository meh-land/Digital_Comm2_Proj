%% Part 2: Inter-Symbol Interference due to multi-path channels
% This file depends on two functions:
% MultiPathBER => Calculates BER for a given Noise and number of
% symbols to send.
% MultipathChannel => Generates a matrix h of dimention LxL, where
% each column corresponds to L channel coefficients for L paths.

%% Prerequisites
clc;
clear;
close all;

%% Defining Variables
% Range of noise for testing
EB_No_db_list = 0:10:140;  

% BER Trials to take average
Trials = 1000; 

% Number of symbols to send
N = 100; 

% BER Array
BER = [];

%% Calculating average BER w.r.t a certain noise value
for EB_No_db = EB_No_db_list
    
    No = 1/(10^(EB_No_db/10));
    average = 0;
    
    % Calculate BER Trial-times and take the average
    for i = 1:Trials
        average = average+ MultiPathBER(N,No);
    end
    average = average/Trials;
    
    % Store average BER at this noise level
    BER = [BER average];
end

%% Plotting BER vs Noise
title('Benchmarking Multi-Path channel BER vs Eb/No')
xlabel('Eb/No (db)') 
ylabel('BER') 
plot(EB_No_db_list,BER);