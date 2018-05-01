clear,clc;

addpath('lib/gco/matlab','lib/S2_Sampling_Suite/S2_Sampling_Toolbox',...
    'lib/nearestneighbour','lib/surfPeterKovesi');

%GCO_UnitTest; % Get GCO lib initialized
path = 'data/data02';
type = '*.bmp';

% Resampling
[imgs, lightVecs] = resampling(path,type);


%find denominator image
[de_img,gray_imgs,I] = find_denominator(imgs,0.7,0.9);

%initial normal estimation
[init_normals,init_normals_pic] = initial_normal(gray_imgs,I,lightVecs );

%refine normal

%build 3d model
model(refined_normals,de_img)
