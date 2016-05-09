%mseCalc.m
%input: a matrix of signal
%rows: time sequence
%columns: channel

%output: return a matrix, 
%rows: entropy
%columns: channel

function output=mseCalc(input)
[~, columns] = size(input);

for i=1:columns
    e(:,i)=msentropy(input(:,i),2,0.15,20);
end

output=e;
end
