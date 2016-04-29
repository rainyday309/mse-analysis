% myFilter.m
% filter the input array with preset butterworth band filter
% preset parameters:
%
% inputs:
% 
% original_signal: input sequence
% range of frequency wanted: [low,high]
% source_sampr: sampling rate of sourcefile


function filtered_signal = myFilter(original_signal, range, source_sampr)
[u,v] = butter(2,range/(source_sampr/2),'bandpass');
filtered_signal = filter(u,v,original_signal);
end
