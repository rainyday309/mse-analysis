% mySpectral.m
% perform power spectral analysis for eeg
% take only 19 electrodes of 10-20 system

function [total, delta_rel, delta_abs, spectra] = mySpectral(eeg)

eeg = eeg(:,1:19);

fs=128;
m=length(eeg);
y=fft(eeg,m);
f=(0:m/2-1)*(fs/m);
power=y.*conj(y)/m;

spectra = power(1:(length(power)/2),:);

delta = [0.1 3.5]*(m/fs);
theta = [4 7.5]*(m/fs);
alpha = [8 13]*(m/fs);
beta = [13.5 30]*(m/fs);

total = sum(spectra);

delta_abs = sum(spectra(delta(1):delta(2),:));
theta_abs = sum(spectra(theta(1):theta(2),:));
alpha_abs = sum(spectra(alpha(1):alpha(2),:));
beta_abs = sum(spectra(beta(1):beta(2),:));

delta_rel = delta_abs./total;
theta_rel = theta_abs./total;
alpha_rel = alpha_abs./total;
beta_rel = beta_abs./total;



plot(f,log2(spectra));

end