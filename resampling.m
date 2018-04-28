function [resImg, Lo] = resampling(srcPath, srcType)

imgList = dir([srcPath '/' srcType]);
num = size(imgList,1);

% read captured light direction                            
Li = textread([srcPath '/lightvec.txt']);
Li = normr(Li);

coor = SubdivideSphericalMesh(IcosahedronMesh, 4);
coor = coor.X;

%get nneighbour
idx = nearestneighbour(Li', coor'); 

%delete repeated points
% disp(size(Li'))
%disp(size(coor'))


[uniqueIdx, ~, revIdx] = unique(idx);
% disp(size(idx))
% disp(size(uniqueIdx))
% disp(size(revIdx));
uniqueNum = length(uniqueIdx); 
Lo = zeros(uniqueNum, 3);
for i = 1:length(uniqueIdx)
    Lo(i,1:3) = coor(uniqueIdx(i),1:3);
end

%interpolate

resImg = zeros([size(double(imread([srcPath '/' imgList(1).name]))) uniqueNum]);
weight = zeros(uniqueNum,1); 


for i = 1:num
    curImg = double(imread([srcPath '/' imgList(i).name]));
    ri = revIdx(i);
    w = coor(idx(i),1:3) * Li(i,1:3)';
    resImg(:,:,:,ri) = resImg(:,:,:,ri) + w * curImg;
    weight(ri) = weight(ri) + w;
end

for i = 1:uniqueNum
    resImg(:,:,:,i) = resImg(:,:,:,i) / weight(i);
end

end 