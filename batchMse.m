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
            title = strcat('epoch',num2str(i),'_ch',num2str(j),'_scale',num2str(k));
            results{1,current_col} = title;
            current_col = current_col + 1;
        end
    end
end

% read data filename from filelist
tline = fgetl(fid);
current_row = 2;


while (ischar(tline))
    % display process
    process = strcat('processing: ',tline);
    disp(process);
    
    % read data
    [~,data] = mseProcess(tline);
    
    % calculate mse, return 3x1 cell array of mse arrays
    msedata = cellfun(@mseCalc, data, 'UniformOutput',false);
    
    name = regexp(tline, 'F[XY]\d{3}','match');
    name = name{1};
    results{current_row,1} = name;
    
    % hard coded size of cell array and column/row number
    current_col = 2;
    
    for a=1:3
        for b=1:20
            for c=1:20
                results{current_row,current_col} = msedata{a}(c,b);
                current_col = current_col + 1;
            end
        end
    end
    
    
    tline = fgetl(fid);
    current_row = current_row + 1;
end

% write cell array into csv


end