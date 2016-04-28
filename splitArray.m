% splitArray.m
% input: 1280n x m matrix
% epochLength: length of each epoch
% this function split matrix into n 1280xm matrices and into cell array

function cellArray = splitArray(input, epochLength)
  vecLength = fix(length(input)/epochLength);
  vec = ones(1,vecLength) * epochLength;
  cellArray = mat2cell(input,vec);
end