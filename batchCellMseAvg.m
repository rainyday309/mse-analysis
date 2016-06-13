% batchCellMseAvg.m
% calculate mse for data in cell array form
% input first column: name of data
% input second column: cell array containing 3 epoch data

function output = batchCellMseAvg(input)

[length,~]=size(input);
% length : total rows of input

output= {};
cells = 3;
channels = 20;
scales = 10;


% write header
output{1,1} = 'name';
current_col = 2;

for i=1:channels
    for j=1:scales
        title = strcat('ch',num2str(i),'_scale',num2str(j));
        output{1,current_col} = title;
        current_col = current_col + 1;
    end
end


% loop through all data and calculate mse
for p=1:length
    current_row = p+1;
    current_col = 2;
    process = strcat('processing: ',input{p,1});
    disp(process);
    
    output{current_row,1} = input{p,1};
    
    msedata = cellfun(@mseCalc, input{p,2}, 'UniformOutput',false);
    
    for i=1:channels
        for j=1:scales
            output{current_row,current_col} = mean([msedata{1}(j,i),msedata{2}(j,i),msedata{3}(j,i)]);
            current_col = current_col + 1;
        end
    end
    
end
    
    
    
    
end