clear,clc;

addpath('lib/gco/matlab','lib/S2_Sampling_Suite/S2_Sampling_Toolbox',...
    'lib/nearestneighbour','lib/surfPeterKovesi');

%GCO_UnitTest; % Get GCO lib initialized
SrcPath = 'data/data02';
SrcType = '*.bmp';

% Resampling
[Imgs, LightVecs] = resampling(srcPath,srcType);

%later steps