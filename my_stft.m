function [S, F, T] = my_stft(x, segment_duration, segment_overlap, samplerate)
% my_stft:
% input
% x: The target signal.
% segment_duration: The number of samples of each segment.
% segment_overlap: The number of samples overlapping on two adjacent segments.
%
% output
% S: Short-time Fourier transform, returned as a matrix. Time increases across the columns of S and frequency increases down the rows, starting from zero.
% F: Cyclical frequencies, returned as a vector. F has a length equal to the number of rows of S.
% T: Time instants, returned as a vector. The time values in T correspond to the midpoint of each segment.

%% Your implementation;

L1 = 2^nextpow2(segment_duration);  %2^10 > 800
x_len = length(x);
hop = segment_duration-segment_overlap;

ham_buildin = hamming(segment_duration, 'periodic');
row = L1/2+1;
segments_num = (x_len-segment_duration)/hop +1;
S = zeros(row,segments_num);

index = 0;

for col=1:segments_num
    xw = x(index+1:index+segment_duration).*ham_buildin;
    index = index +  hop;
    fft_xw = fft(xw,L1);
    S(:,col) = fft_xw(1:row);
end   

F = samplerate/2*linspace(0,1,row);  %mirror nature
T = (segment_duration/2:hop:segment_duration/2+(segments_num-1)*hop)/samplerate; %1/samplerate to time
