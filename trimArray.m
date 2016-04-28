% trimArray.m 
% input: input 1xn array
% epochLength: length of epoch to be use as divider
% this file filters the input 1xn array into maxima length dividable by
% epochLength

function newArray = trimArray(input,epochLength)
n = fix(length(input)/epochLength) * epochLength;
newArray = input(1:n,:);
end