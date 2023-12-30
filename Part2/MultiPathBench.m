EB_No_db_list = 0:10:140;  % noises to test
Trials = 1000; % BER Trials to take average
N = 100; % Symbols to send
BER = [];
for EB_No_db = EB_No_db_list
    No = 1/(10^(EB_No_db/10));
    average = 0;
    for i = 1:Trials
        average = average+ MultiPathBER(N,No);
    end
    average = average/Trials;
    BER = [BER average];
end
title('Benchmarking Multi-Path channel BER vs Eb/No')
xlabel('Eb/No (Db)') 
ylabel('BER') 
plot(EB_No_db_list,BER);