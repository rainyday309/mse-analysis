% plotCheck.m
% draw plots and save to file
% input format: a cell array {n,2}
% 2nd column contain an cell array 1x3
% each cell array contain an array 1280x20

function plotCheck(name, data)
[length,~] = size(data);



for i=1:length
    subplot(length,1,i);
    plot(data{i}(:,1));
end

subplot(length,1,1);
title(name);



end
