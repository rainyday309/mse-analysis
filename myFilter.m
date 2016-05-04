% myFilter.m
% filter the input array with preset butterworth band filter
% preset parameters:
%
% inputs:
% 
% original_signal: input sequence
% range of frequency wanted: [low,high]
% source_sampr: sampling rate of sourcefile


function final_signal = myFilter(original_signal, range, source_sampr)
% notch filter for 60Hz
notch = designfilt('bandstopiir', 'FilterOrder', 2, 'HalfPowerFrequency1', 59, 'HalfPowerFrequency2', 61, 'SampleRate', 128, 'DesignMethod', 'butter');
filtered_signal = filtfilt(notch, original_signal);

% bandpass filter for designated frequency range
[u,v] = butter(2,range/(source_sampr/2),'bandpass');
final_signal = filter(u,v,filtered_signal);
end
