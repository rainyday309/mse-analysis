% mytopo.m
% draw topoplot with imported vector
function mytopo(input, limits)
  places = readlocs('10-20.ced');
  topoplot(input,places,'headrad',0.53,'maplimits',limits);
  
end