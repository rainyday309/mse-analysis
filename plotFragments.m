% plotChannel.m
% input: an cell array contain n cells
% channel: the channel picked to be displayed

% open a 


function plotFragments(input, channel)

figure();
[length, ~] = size(input);

for i=1:length
    subplot(length,1,i);
    plot(input{i}(:,channel));
    ylim([-50 50]);
end


end
