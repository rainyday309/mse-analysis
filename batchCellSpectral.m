%batchCellSpectral.m
%a script for batch calculating spectral analysis parameters 
%output: a mxn cell array, contains filename and the spectral analysis
%parameters

function output = batchCellSpectral(input)
[length,~]=size(input);
channels = {'FP1', 'FP2', 'F7', 'F3', 'Fz', 'F4', 'F8', 'T3', 'C3', 'Cz', 'C4', 'T4', 'T5', 'P3', 'Pz', 'P4', 'T6', 'O1', 'O2'};
tags = {'total_power','delta_abs','theta_abs','alpha_abs','beta_abs','delta_rel','theta_rel','alpha_rel','beta_rel'};
output = {};

% write header
output{1,1} = 'name';
current_col = 2;

for i=1:9
    %each tag
    for j=1:19
        %each channel
        title = strcat(tags{i},'_',channels{j});
        output{1,current_col} = title;
        current_col = current_col + 1;
    end
end



for p=1:length
    temp = mySpectral(input{p,2});
    current_row = p+1;
    output{current_row,1}=input{p,1};
    current_col = 2;
    process = strcat('processing: ',input{p,1});
    disp(process);
    
    for i=1:9
        for j=1:19
            output{current_row,current_col}=temp{2,i}(j);
            current_col = current_col + 1;
        end
    end
end

end

