file list:

# dependency and pre-requisites  

### calculating multi-scale entropy  
- sampenc.m  
- coarsegraining.m  
- msentropy.m  
courtesy of Dr. Albert C. Yang,  
he rewrote original program in MATLAB from M. Costa's code, which is in written in C  
[original code](https://www.physionet.org/physiotools/mse/tutorial/node3.html)

### load EEG data from binary  
- loaddat.m  
read eeg data from brain-atlas III machine  
from [here](http://pub.ist.ac.at/~schloegl/matlab/eeg/)  

format of data output:  
1. an matrix of 20xn, contain voltage from 20 channels  
2. sampling rate at 128Hz  
3. unit: microVolt  

### main script: process.m  
- batchMse.m(obsolete) : input filelist, output cell array with entropy in each epoch ,channel and scale factor  
- batchCheck.m : input filelist, output nx2 cell array, {k,1} as filename and {k,2} as 3 epochs selected from each file  
- plotCheck.m(obsolete) : draw plot in picked channel of 3 epochs from single file, for double check  
- batchCellMse : input cell array, return cell array with entropy in each epoch, channel and scale factor  
- batchCellMseAvg : input cell array, return cell array with mean entropy in each epoch, channel and scale factor  
- batchCellSpectral : input cell array, return cell array with spectral analysis results  


### functions for hand picking
- plotFragments : plot 3 epoches in one specific channel  
- plotChannels : plot one epoch in all channels  

### data handling for each file in mseProcess.m 
- trimArray.m : trim matrix to 20x1280n, for splitting array into 10sec epoch  
- myFilter.m : notch filter: filter out 60Hz noise from power supply  
- myFilter.m : butterworth band filter, filter out frequency < 1Hz and > 30 Hz (modified 2016.5.23)  
- splitArray.m : cut matrix into n submatrix with size of 1280x20, returned in cell array  
- fft each epoch and return power spectrum of each epoch  
- mysnr.m : calculate signal-noise ratio (percentage of power at alpha and beta range) of each epoch  
- snrRanking.m : select 3 epoch with best signal-noise ratio (only check Fp1, Fp2 because these two has most blink noise)(modified 2016.5.23)  
- mseCalc.m : calculate multi-scale entropy of epoch, rows: scaling factor, column: channel (scale factor only calculate to 10)  

### memo  
get result list for handpicking:
results = batchCheck('filelist_fix.txt');
