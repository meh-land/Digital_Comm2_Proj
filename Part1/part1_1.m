%% The first thing you need to show here is the effect of a band-limited flat channel on the square signal.
% You need to create a band-limited channel such as the one in Figure 1, with a band B = 100 kHz.
% Then generate a square pulse of duration T = 2/B, pass it through the filter, and then look at the output.
% You need here to show the signal before and after the channel, both in time and in frequency.

clc;
close all;
clear;

% Define parameters
B = 100e3; % Bandwidth of the channel in Hz
T = 2 / B; % Duration of the square pulse in seconds
Fs = 10 * B; % Sampling frequency, at least ten times the bandwidth

%% Generate a single square pulse of duration T centered at t=0
% Create a time vector
t = -5*T:1/Fs:5*T;
square_pulse = zeros(1, length(t));
square_pulse(t >= -T/2 & t < T/2) = 1;

%% Create the frequency response of a band-limited channel
% For a flat channel, we simply block frequencies outside +/- B
f = linspace(-Fs/2, Fs/2, length(t));
H = double(abs(f) <= B);

% Apply the channel to the signal in frequency domain
square_pulse_fft = fftshift(fft(square_pulse));
filtered_pulse_fft = square_pulse_fft .* H;
filtered_pulse = ifft(ifftshift(filtered_pulse_fft));

%% Plot the time domain signal before and after the channel
figure;
subplot(2,1,1);
plot(t, square_pulse);
hold on;
plot(t, real(filtered_pulse)); % Real part due to numerical precision
title('Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original Square Pulse', 'After Band-limited Channel');
grid on;

%% Plot the frequency domain signal before and after the channel
subplot(2,1,2);
plot(f, abs(square_pulse_fft) / max(abs(square_pulse_fft)));
hold on;
plot(f, abs(filtered_pulse_fft) / max(abs(filtered_pulse_fft)));
title('Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Normalized Magnitude');
legend('Original Square Pulse', 'After Band-limited Channel');
grid on;
