% mysnr.m 
% 
% calculate signal-noise ratio
% alpha frequency: 8-12Hz
% beta frequency: 13-30Hz
% input: an matrix of fft output, length 128
% output: an array of signal-noise ratio on each channel

function output = mysnr(input)
% norm of fft output complex vector
input = abs(input);

% signal in defined to be 8-30Hz, noise is those outside signal range
signal = input(8:30,:).^2;
noise = input([1:7,31:64],:).^2;

signal = sum(signal);
noise = sum(noise);

output = signal./noise;

end
