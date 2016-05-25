%plotChannels.m
%input: an array contain 1280*n array
%plot a signal in all channels

function plotChannels(input)

figure();
for i=1:20
    subplot(i,1,20);
    plot(input(:,i));
end

end