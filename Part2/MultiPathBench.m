% Range of noise for testing
EB_No_db_list = 0:10:140;  

% BER Trials to take average
Trials = 1000; 

% Number of symbols to send
N = 100; 

% BER Array
BER = [];

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

% Plot BER vs Noise
title('Benchmarking Multi-Path channel BER vs Eb/No')
xlabel('Eb/No (db)') 
ylabel('BER') 
plot(EB_No_db_list,BER);