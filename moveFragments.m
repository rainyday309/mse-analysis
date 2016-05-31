% moveFragments.m
% move selected epochs to selected epochs 

function moveFragments(line)

for loop=1:3
    order = strrep('selected{line,2}{loop}=selected{line,3}{selected{line,4}(loop)};','line',num2str(line));
    order = strrep(order,'loop',num2str(loop));
    plotorder = strrep('plotChannels(selected{line,2}{loop});','line',num2str(line));
    plotorder = strrep(plotorder,'loop',num2str(loop));
    % disp(order);
    % disp(plotorder);
    evalin('base',order);
    evalin('base',plotorder);
end

end