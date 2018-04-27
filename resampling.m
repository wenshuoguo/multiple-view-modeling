function [resImg, Lo] = resampling(srcPath, srcType)

%section 4.2 in the paper

% read captured light direction                            
Li = textread([SrcPath '/lightvec.txt']);
Li = normr(Li);

TR = SubdivideSphericalMesh(IcosahedronMesh, 4);
coor = TR.X;

%get nneighbour
idx = nearestneighbour(Li', coor'); 

%delete repeated points

[uniqueIdx, ~, revIdx] = unique(idx);
uniqueNum = length(uniqueIdx); 
Lo = zeros(uniqueNum, 3);
for i = 1:length(uniqueIndex)
    Lo(i,:) = coor(uniqueIndex(i),:,:);
end

%Interpolate




end 