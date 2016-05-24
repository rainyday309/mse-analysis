% plotCheck.m
% draw plots and save to file
% input format: a cell array {n,2}
% 2nd column contain an cell array 1x3
% each cell array contain an array 1280x20

function plotCheck(name, data, channel)
[length,~] = size(data);



for i=1:length
    subplot(length,1,i);
    plot(data{i}(:,channel));
end

subplot(length,1,1);
title(strcat(name,' channel ',num2str(channel)));



saveas(gcf,[pwd strcat('/recheck_plots/',name,'_channel_',num2str(channel),'.jpg')]);

end
