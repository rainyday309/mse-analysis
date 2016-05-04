%mseProcess.m
%read the data step by step and spit output
%all outside parameter is set here

function output = mseProcess(filename)
% read data by filename
[v,~,~,~] = loaddat(filename,21);

% filter the signal before truncating data
v_filtered = myFilter(v,[1,63],128);

% truncate data
vtrim = trimArray(v_filtered,1280);
vcell = splitArray(vtrim,1280);

% fft each cell
% output = cellfun(filter, vcell, 'UniformOutput',false);
output = vcell;

end