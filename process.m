% process.m
% contain complete process for mse data
% input: a text file contain all file names
% output: a cell array contain names


% read data in batch, automatically split and rank sr ratio
data = batchCheck('listname.txt');

% hand editing and picking epoches
result_mse = batchCellMseAvg(data);
result_spectral = batchCellSpectral(data);