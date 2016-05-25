% moveFragments.m
% move selected epochs to selected epochs 

function moveFragments(input,line)

for i=1:3
    input{line,2}{i} = input{line,3}{input{line,4}(i)};
    plotChannels(input{line,2}{i});
end

end