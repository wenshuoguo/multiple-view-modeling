clear,clc;

addpath('lib/gco/matlab','lib/S2_Sampling_Suite/S2_Sampling_Toolbox',...
    'lib/nearestneighbour','lib/surfPeterKovesi');

%GCO_UnitTest; % Get GCO lib initialized
path = 'data/data02';
type = '*.bmp';

% Resampling
[imgs, lightVecs] = resampling(path,type);

%later steps