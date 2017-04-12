%%% HW2_Q1.m - Complete the procedure of separating HW2_mix.wav into 3 songs

%% Clean variables and screen
close all;
clear;
clc;

%% Visualization parameters (Change it if you want)
% Some Tips:
% (Tip 1) You can change the axis range to make the plotted result more clearly
% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure
titlefont = 15;
fontsize = 13;
LineWidth = 1.5;

%% 1. Read in input audio file ( audioread )
% y_input: input signal, fs: sampling rate
[y_input, fs] = audioread('audio/HW2_Mix.wav');

%%% Plot example : plot the input audio
% The provided function "make_spectrum" generates frequency
% and magnitude. Use the following example to plot the spectrum.
figure
[frequency, magnitude] = make_spectrum(y_input, fs);
plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('Input', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize)
N = 10001;
%% 2. Filtering
% (Hint) Implement my_filter here
% [...] = my_filter(...);
[low_pass_output,low_pass_filter] = my_filter(y_input,fs,N,'Blackmann','low-pass',400); %little bee
[high_pass_output,high_pass_filter] = my_filter(y_input,fs,N,'Blackmann','high-pass',800); %two tigers
[bandpass_output,bandpass_filter] = my_filter(y_input,fs,N,'Blackmann','bandpass',[400,800]);
%london bridge

%%% Plot the shape of filters in Time domain
figure
plot((0:1/fs:1/fs*(N-1)), low_pass_filter, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('Low filter(0~400 HZ) Time domain', 'fontsize', titlefont);
xlabel('time');
ylabel('magnitude');
set(gca, 'fontsize', fontsize)
figure
plot((0:1/fs:1/fs*(N-1)), high_pass_filter, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('High filter(800up HZ) Time domain', 'fontsize', titlefont);
xlabel('time');
ylabel('magnitude');
set(gca, 'fontsize', fontsize)
figure
plot((0:1/fs:1/fs*(N-1)), bandpass_filter, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('Bandpass filter(400~800 HZ) Time domain', 'fontsize', titlefont);
xlabel('time');
ylabel('magnitude');
set(gca, 'fontsize', fontsize)

%%% Plot the spectrum of filters (Frequency Analysis)
figure
[frequency_low, magnitude_low] = make_spectrum(low_pass_filter, fs);
plot(frequency_low, magnitude_low, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('Low filter(0~400 HZ) spectrum', 'fontsize', titlefont);
xlabel('frequency');
ylabel('magnitude');
set(gca, 'fontsize', fontsize)
figure
[frequency_high, magnitude_high] = make_spectrum(high_pass_filter, fs);
plot(frequency_high, magnitude_high, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('High filter(800up HZ) spectrum', 'fontsize', titlefont);
xlabel('frequency');
ylabel('magnitude');
set(gca, 'fontsize', fontsize)
figure
[frequency_bp, magnitude_bp] = make_spectrum(bandpass_filter, fs);
plot(frequency_bp, magnitude_bp, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('Bandpass filter(400~800 HZ) spectrum', 'fontsize', titlefont);
xlabel('frequency');
ylabel('magnitude');
set(gca, 'fontsize', fontsize)

%% 3. Save the filtered audio (audiowrite)
% Name the file 'FilterName_para1_para2.wav'
% para means the cutoff frequency that you set for the filter

% audiowrite('FilterName_para1_para2.wav', output_signal1, fs);

audiowrite('lowpass_400.wav', low_pass_output, fs);
audiowrite('highpass_800.wav', high_pass_output, fs);
audiowrite('bandpass_400_800.wav', bandpass_output, fs);

%%% Plot the spectrum of filtered signals
figure
[frequency_low_s, magnitude_low_s] = make_spectrum(low_pass_output, fs);
plot(frequency_low_s, magnitude_low_s, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('Low filtered(0~400 HZ) signals', 'fontsize', titlefont);
xlabel('frequency');
ylabel('magnitude');
set(gca, 'fontsize', fontsize)
figure
[frequency_high_s, magnitude_high_s] = make_spectrum(high_pass_output, fs);
plot(frequency_high_s, magnitude_high_s, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('High filtered(800up HZ) signals', 'fontsize', titlefont);
xlabel('frequency');
ylabel('magnitude');
set(gca, 'fontsize', fontsize)
figure
[frequency_bp_s, magnitude_bp_s] = make_spectrum(bandpass_output, fs);
plot(frequency_bp_s, magnitude_bp_s, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
title('Bandpass filtered(400~800 HZ) signals', 'fontsize', titlefont);
xlabel('frequency');
ylabel('magnitude');
set(gca, 'fontsize', fontsize)
