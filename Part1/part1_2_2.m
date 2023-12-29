clc;
close all;
clear all;

% Define parameters
B = 100e3; % Bandwidth of the channel in Hz
T = 2 / B; % Duration of the square pulse in seconds
Fs = 10 * B; % Sampling frequency, at least ten times the bandwidth

%% Generate two seperate square pulses of duration T
% Create a time vector
t = -2*T:1/Fs:5*T;

%Creating two consecutive square pulses, each of T = 2 / B, 

square_pulse_0 = zeros(1, length(t));
square_pulse_1 = zeros(1, length(t));

square_pulse_0(t >0 & t < T) = 1;
square_pulse_1(t >= T & t <2*T) = 1;

%% Create the frequency response of a band-limited channel
% For a flat channel, we simply block frequencies outside +/- B
f = linspace(-Fs/2, Fs/2, length(t));
H = double(abs(f) <= B);

% % Apply the channel to the signal in frequency domain
% square_pulse_0_fft = fftshift(fft(square_pulse_0).*exp(i*2*pi*f*T/2));

square_pulse_0_fft = fftshift(fft(square_pulse_0));
square_pulse_1_fft = fftshift(fft(square_pulse_1));



filtered_pulse_0_fft = square_pulse_0_fft .* H;
filtered_pulse_0 = ifft(ifftshift(filtered_pulse_0_fft));

filtered_pulse_1_fft = square_pulse_1_fft .* H;
filtered_pulse_1 = ifft(ifftshift(filtered_pulse_1_fft));



%% Plotting Ground (For Testing)

figure
subplot(2,1,1)
plot(t, square_pulse_0,'r', 'LineWidth', 1);
hold on
plot(t, square_pulse_1,'g', 'LineWidth', 1);
title('Time Domain Before Channel');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Pulse 0', 'Pulse 1');
grid on;
grid minor

subplot(2,1,2)
plot(t, abs(filtered_pulse_0),'r', 'LineWidth', 1);
hold on
plot(t, abs(filtered_pulse_1),'g', 'LineWidth', 1);
title('Time Domain After Channel');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Pulse 0', 'Pulse 1');
grid on;
grid minor


