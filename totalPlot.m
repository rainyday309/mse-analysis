% totalPlot.m
% input: an cell array with selected epochs from batchCheck.m

function totalPlot(results)
for j=1:232
    for k=1:20
        plotCheck(results{j,:},k)
    end
end
end
