file list:

### calculating multi-scale entropy
- sampenc.m
- coarsegraining.m
- msentropy.m

### load EEG data from binary 
- loaddat.m

format of data output:
1. an matrix of 20xn, contain voltage from 20 channels
2. sampling rate at 128Hz
3. unit: microVolt

### data handling for each patient
- trimArray.m : trim matrix to 20x1280n, for splitting array into 10sec epoch
- butterworth band filter, filter out frequency < 1Hz and > 70 (32?) Hz
- splitArray.m : cut matrix into n submatrix with size of 20x1280, returned in cell array
- fft each epoch and return power spectrum of each epoch
- calculate signal-noise ratio (percentage of power at alpha and beta range) of each epoch
- select 3 epoch with best signal-noise ratio
- calculate multi-scale entropy of each of these 3 epoch

### overall data handling
- return multi-scale entropy of selected epoch for all these patients
- data coding:
pre-mse-1-n
pre-mse-2-n
pre-mse-3-n
post-mse-1-n
post-mse-2-n
post-mse-3-n
avg-pre-mse-n
avg-post-mse-n
- statistics
average and se of avg-pre-mse-n
average and se of avg-post-mse-n
compare treatment group mse change with paired t-test
compare control with treatment pre-mse
compare control with treatment post-mse
