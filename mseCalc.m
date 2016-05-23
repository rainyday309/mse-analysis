%mseCalc.m
%input: a matrix of signal
%rows: time sequence
%columns: channel

%output: return a matrix, 
%rows: entropy in each scale factor
%columns: channel

function output=mseCalc(input)
[~, columns] = size(input);

for i=1:columns
    % 20160523: scale factor calculate to 10
    e(:,i)=msentropy(input(:,i),2,0.15,10);
end

output=e;
end
