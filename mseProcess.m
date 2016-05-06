%mseProcess.m
%read the data step by step and spit output
%all outside parameter is set here

function output = mseProcess(filename)
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
snrarray = cell2mat(snrcell)';

% output = cellfun(filter, vcell, 'UniformOutput',false);
output = snrarray;

% current problem: signal-noise ratio ranking is different at each channel
% we should pick the three with most channel in top 3

end