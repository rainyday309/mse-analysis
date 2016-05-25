% batchCheck.m
% 
% input: a file contain all data filenames
% output: a cell array, 1st item contain filename, then a cell array
% contain 3 epochs

function results = batchCheck(filename)

fid = fopen(filename);
cells = 3;
channels = 20;
rows = 10;

results = {};

% read data filename from filelist
tline = fgetl(fid);
current_row = 1;

while (ischar(tline))
    % display process
    process = strcat('processing: ',tline);
    disp(process);
    
    % read and select epochs
    % all = all epoches from single file
    % data = selected epoches
    [all,data,label,snrarray] = mseProcess(tline);
    
    % write cell arrays
    name = regexp(tline, 'F[XY]\d{3}','match');
    name = name{1};
    results{current_row,1} = name;
    results{current_row,2} = data;
    results{current_row,3} = all;
    results{current_row,4} = label;
    results{current_row,5} = snrarray;
    
    tline = fgetl(fid);
    current_row = current_row + 1;
end


end