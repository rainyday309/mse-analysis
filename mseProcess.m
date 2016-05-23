%mseProcess.m
%read the data step by step and spit output
%all outside parameter is set here
%returns:
%vcell: cells of truncated signal

function [vcell,output] = mseProcess(filename)
% read data by filename
[v,~,~,~] = loaddat(filename,21);

% filter the signal before truncating data
% data could not provide high gamma frequency
% 20160519: bandpass filter 1Hz-45Hz
% 20160523: bandpass filter set to 1Hz-30Hz
v_filtered = myFilter(v,[1,30],128);

% truncate data
vtrim = trimArray(v_filtered,1280);
vcell = splitArray(vtrim,1280);

% fft each cell, sampling frequency set to 128Hz
vcellfft = cellfun(@(x) fft(x,128), vcell, 'UniformOutput', false);

% calculate signal-noise ratio at every channel of each epoch
snrcell = cellfun(@mysnr,vcellfft,'UniformOutput',false);
% snrarray = cell2mat(snrcell)';
snrarray = cell2mat(snrcell);

% ranking only use Fp1 and Fp2 (channel 1,2)
% slice snrarray to contain only Fp1 and Fp2
snrarray = snrarray(:,1:2);

% signal-noise ratio ranking is different at each channel
% we pick the three with most channel in top 3
% get index of cell array index with most channels with snr in top 3 
% return subarrays selected
selected = snrRanking(snrarray);
output = vcell(selected);

% so far completed automation of 
% trimming signal
% filtering signal
% do fft to each signal, calculate signal-noise ratio
% pick epoch with best signal-noise ratio

% now we will perform mse calculation on each epoch we selected
% and record them into csv file

end