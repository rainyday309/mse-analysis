% myFilterHandler: return a handler of myFilter with preset range and source_sampr
% used for cellfun to handle cell array of matrices of input data

function handler = myFilterHandler(range, source_sampr)
handler = @(mat) myFilter(mat,range,source_sampr);
end