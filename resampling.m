function [resImg, Lo] = resampling(srcPath, srcType)

imgList = dir([srcPath '/' srcType]);
num = size(imgList,1);

% read captured light direction                            
Li = textread([SrcPath '/lightvec.txt']);
Li = normr(Li);

coor = SubdivideSphericalMesh(IcosahedronMesh, 4);
coor = coor.X;

%get nneighbour
idx = nearestneighbour(Li', coor'); 

%delete repeated points

[uniqueIdx, ~, revIdx] = unique(idx);
uniqueNum = length(uniqueIdx); 
Lo = zeros(uniqueNum, 3);
for i = 1:length(uniqueIndex)
    Lo(i,:) = coor(uniqueIndex(i),:,:);
end

%interpolate

resImg = zeros([size(double(imread([SrcPath '/' imgList(1).name]))) uniqueNum]);
weight = zeros(uniqueNum, 1); 

for i = 1:num
    curImg = double(imread([SrcPath '/' imgList(i).name]));
    ri = revIdx(i);
    w = coor(NNIndex(i),:,:) * Li(i,:,:)';
    resImg(:,:,:,ri) = resImg(:,:,:,ri) + w * curImg;
    weight(ri) = weight(ri) + w;
end

for i = 1:uniqueNum
    resImg(:,:,:,i) = resImg(:,:,:,i) / weight(i);
end

end 