function [ refined_normals_reshape ] = MRF_refined( init_normals,gray_imgs,I)
% get label set
coor = SubdivideSphericalMesh(IcosahedronMesh, 5);
coor = coor.X;
[NumLabels,~]= size(coor);
[NumImgs,height,width] = size(gray_imgs);
NumSites = height*width;

%retrieve denominator_img
de_img = gray_imgs(I,:,:);

init_normals_reshape = zeros(NumSites,3);

for i=1:height
    for j=1:width
        init_normals_reshape((i-1)*width+j,:) = init_normals(i,j,:);
    end
end

Labeling = zeros(1,NumSites);
% get labels
for i=1:NumSites
    cos_similarity = coor*init_normals_reshape(i,:)';
    [M,I] = max(cos_similarity);
    Labeling(i) = I;
end
%create handler
Handle = GCO_Create(NumSites,NumLabels);

%preset label
GCO_SetLabeling(Handle,Labeling);


DataCost = zeros(NumLabels,NumSites);
for i = 1:NumLabels
    for j = 1:NumSites
        DataCost(i,j) = norm(coor(i,:)-init_normals_reshape(j,:));
    end
end
GCO_SetDataCost(Handle,DataCost);

Weights = zeros(NumSites,NumSites);

for i = 1:NumSites
    if ceil((i-1)/width) == ceil(i/width) && (i-1)>=1
        Weights(i-1,i) = 1;
    end
    if ceil((i+1)/width) == ceil(i/width) && (i+1)<=NumSites
        Weights(i,i+1) = 1;
    end
    if (i-width)>=1
        Weights(i-width,i)=1;
    end
    if(i+width)<=NumSites
        Weights(i,i+width) = 1;
    end
end
GCO_SetNeighbors(Handle,Weights);

SmoothCost = zeros(NumLabels,NumLabels);
for i=1:NumLabels
    for j=1:NumLabels
        SmoothCost(i,j) = norm(coor(i,:)-coor(j,:));
    end
end
SmoothCost = log(SmoothCost/(2*0.65*0.65)+1)*0.5;
GCO_SetSmoothCost(Handle,SmoothCost);

GCO_Expansion(Handle);

refined_normals = zeros(NumSites,3);
Result_Labeling = GCO_GetLabeling(Handle);
for i=1:NumSites
    refined_normals(i,:) = coor(Result_Labeling(i),:);
end

refined_normals_reshape = zeros(height,width,3);

for i=1:NumSites
    row = ceil(i/width);
    col = i - (row-1)*width;
    
    refined_normals_reshape(row,col,:) = refined_normals(i,:);
end

end

