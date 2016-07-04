% mySpectral.m
% perform power spectral analysis for eeg
% take only 19 electrodes of 10-20 system

function [result] = mySpectral(eeglist)

fs=128;

total_sum=zeros(1,19);
delta_abs_sum=zeros(1,19);
theta_abs_sum=zeros(1,19);
alpha_abs_sum=zeros(1,19);
beta_abs_sum=zeros(1,19);
delta_rel_sum=zeros(1,19);
theta_rel_sum=zeros(1,19);
alpha_rel_sum=zeros(1,19);
beta_rel_sum=zeros(1,19);



for(i=1:3)
    eeg = eeglist{i}(:,1:19);


    m=length(eeg);
    y=fft(eeg,m);
    f=(0:m/2-1)*(fs/m);
    power=y.*conj(y)/m;
    
    % calculate attributes for this round

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

    
    subplot(1,3,i);
    plot(f,log2(spectra));
    
    delta_rel = delta_abs./total;
    theta_rel = theta_abs./total;
    alpha_rel = alpha_abs./total;
    beta_rel = beta_abs./total;
    
    total_sum = total_sum + total;
    delta_abs_sum = delta_abs_sum + delta_abs;
    theta_abs_sum = theta_abs_sum + theta_abs;
    alpha_abs_sum = alpha_abs_sum + alpha_abs;
    beta_abs_sum = beta_abs_sum + beta_abs;
    delta_rel_sum = delta_rel_sum + delta_rel;
    theta_rel_sum = theta_rel_sum + theta_rel;
    alpha_rel_sum = alpha_rel_sum + alpha_rel;
    beta_rel_sum = beta_rel_sum + beta_rel;
    
    
end

result={};

result{1,1} = 'total_power';
result{2,1} = total_sum./3;

result{1,2} = 'delta_abs';
result{2,2} = delta_abs_sum./3;

result{1,3} = 'theta_abs';
result{2,3} = theta_abs_sum./3;

result{1,4} = 'alpha_abs';
result{2,4} = alpha_abs_sum./3;

result{1,5} = 'beta_abs';
result{2,5} = beta_abs_sum./3;

result{1,6} = 'delta_rel';
result{2,6} = delta_rel_sum./3;

result{1,7} = 'theta_abs';
result{2,7} = theta_abs_sum./3;

result{1,8} = 'alpha_abs';
result{2,8} = alpha_abs_sum./3;

result{1,9} = 'beta_abs';
result{2,9} = beta_abs_sum./3;



end