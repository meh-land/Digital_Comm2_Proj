function BER = MultiPathBER(N,No)
% How to use:
%
% BER = MultiPathBER(N,No) - Calculates BER for a given Noise and number of
% symbols to send


L=N;  % Different paths simulated

Eb = 1;
X = randi([0 1], N,1);
Transmitted = X*2-1;  % Baseband BPSK
h = MultipathChannel(L);
Noise = sqrt(No/2)*randn(N,1);

Y = h*Transmitted+Noise; % After channel and noise
% Assuming the reciever knows the channel properties h
h_inv = inv(h);

Received = h_inv*Y;
decode = Received>0;

BER = (sum(decode~=X)/N);