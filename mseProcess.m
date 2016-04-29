%mseProcess.m
%read the data step by step and spit output
%all outside parameter is set here

function output = mseProcess(filename)
% read data by filename
[v,~,~,~] = loaddat(filename,21);

vtrim = trimArray(v,1280);
vcell = splitArray(vtrim,1280);

% question: we will cut the matrix into chunks.
% should I apply filter before or after splitting the array?
filter = myFilterHandler([1,32],128);
output = cellfun(filter, vcell, 'UniformOutput',false);

end