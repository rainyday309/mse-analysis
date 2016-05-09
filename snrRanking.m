% snrRanking.m
% return indices of epoch, that has most channels in top 3 highest
% signal-noise ratio

% input: a matrix, column = channel, row = nth epoch 

function output = snrRanking(input)
% get input row and column number
[rows, ~] = size(input);

% sort in snr, pick 3rd largest number in each column
% then return the boolean whether larger than 3rd largest in each column
inputSorted = sort(input,'descend');
mask = input >= repmat(inputSorted(3,:),[rows,1]);

ranking = sum(mask,2);

rankingSorted = sort(ranking,'descend');

result = find(ranking >= rankingSorted(3));
output = result(1:3);
end