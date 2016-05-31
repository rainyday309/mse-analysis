% totalPlot.m
% input: an cell array with selected epochs from batchCheck.m

function totalPlot(results)
for j=1:232
    for k=1:20
        plotSave(results{j,1},results{j,2},k);
    end
end
end
