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
v_filtered = myFilter(v,[1,45],128);

% truncate data
vtrim = trimArray(v_filtered,1280);
vcell = splitArray(vtrim,1280);

% fft each cell, sampling frequency set to 128Hz
vcellfft = cellfun(@(x) fft(x,128), vcell, 'UniformOutput', false);

% calculate signal-noise ratio at every channel of each epoch
snrcell = cellfun(@mysnr,vcellfft,'UniformOutput',false);
% snrarray = cell2mat(snrcell)';
snrarray = cell2mat(snrcell);

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