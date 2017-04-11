function [outputSignal, outputFilter] = my_filter(inputSignal, fsample, N, windowName, filterName, fcutoff)
%%% Input
% inputSignal: input signal
% fsample: sampling frequency
% N : size of FIR filter(odd)
% windowName: 'Blackmann'
% filterName: 'low-pass', 'high-pass', 'bandpass', 'bandstop'
% fcutoff: cut-off frequency or band frequencies
%       if type is 'low-pass' or 'high-pass', para has only one element
%       if type is 'bandpass' or 'bandstop', para is a vector of 2 elements

%%% Ouput
% outputSignal: output (filtered) signal
% outputFilter: output filter

%% 1. Normalization
N = N-1;
fcutoff = fcutoff/fsample;
middle = N/2;
%% 2. Create the filter according the ideal equations (slide #76)
% (Hint) Do the initialization for the outputFilter here
% if strcmp(filterName,'?') == 1
% ...
% end
if strcmp(filterName,'low-pass')==1
   for n = N/2:-1:-N/2
       if(n==0)
           outputFilter(middle+1) = 1;
       else
           outputFilter(n+middle+1) = sin(2*pi*fcutoff*n)/(pi*n);
       end
   end
   outputFilter(middle+1) = 2*fcutoff;
elseif strcmp(filterName,'high-pass')==1
   for n = N/2:-1:-N/2
       if(n==0)
           outputFilter(middle+1) = 1;
       else
           outputFilter(n+middle+1) = -(sin(2*pi*fcutoff*n)/(pi*n));
       end
   end
   outputFilter(middle+1) = 1-2*fcutoff;
elseif strcmp(filterName,'bandpass')==1
   for n = N/2:-1:-N/2
       if(n==0)
           outputFilter(middle+1) = 1;
       else
           outputFilter(n+middle+1) = (sin(2*pi*fcutoff(2)*n)/(pi*n)) - (sin(2*pi*fcutoff(1)*n)/(pi*n));
       end
   end
   outputFilter(middle+1) = 2*(fcutoff(2)-fcutoff(1));
end

%% 3. Create the windowing function (slide #80) and Get the realistic filter
% if strcmp(windowName,'Blackman') == 1
%     % do it here
% end
if strcmp(windowName,'Blackmann') == 1
   for n = 1:N
       outputFilter(n) = outputFilter(n) * (0.42 - 0.5*cos((2*pi*(n-1))/(N-1)) + 0.08*cos((4*pi*(n-1))/(N-1)));
   end
end
%% 4. Filter the input signal in time domain. Do not use matlab function 'conv'
outputSignal = zeros( length(inputSignal) , 1);

for i = 1:length(inputSignal)
    for j = 1:length(outputFilter)
        if(i-j+1>0)
            outputSignal(i) = outputSignal(i) + inputSignal(i-j+1)*outputFilter(j);
        else
            break;
        end
    end
end
