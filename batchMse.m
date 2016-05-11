% batchMse.m
% usage: batchMse('name of filelist')
% read file name from filelist.txt
% calculate mse of each file. get cell arrays of mse
% write mse of each file into .csv file

function results = batchMse(input)

fid = fopen(input);
cells = 3;
channels = 20;
rows = 20;
results = {};

% write header
results{1,1} = 'name';
current_col = 2;

for i=1:cells
    for j=1:channels
        for k=1:rows
            title = strcat(num2str(i),'_ch',num2str(j),'_scale',num2str(k));
            results{1,current_col} = title;
            current_col = current_col + 1;
        end
    end
end
tline = fgetl(fid);

while (ischar(tline))
    process = strcat('processing: ',tline);
    disp(process);
    
    % [~,data] = mseProcess(tline);
    % msedata = cellfun(@mseCalc, data, 'UniformOutput',false);
    
    % name = regexp(tline, 'F[XY]\d{3}','match');
    
    
    
    tline = fgetl(fid);
end

% write cell array into csv


end