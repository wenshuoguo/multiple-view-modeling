function [ init_normals,init_normals_pic ] = initial_normal(gray_imgs,I,lightVecs )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[uniqueNum,height,width] = size(gray_imgs);
de_img = gray_imgs(I,:,:);
L2 = lightVecs(I,1:3);
M = zeros(height,width,uniqueNum-1,3);
init_normals = zeros(height,width,3);
init_normals_pic = zeros(height,width);
for n = 1:uniqueNum-1
    if n==I(1)
        continue;
    end
    L1 = lightVecs(n,1:3);
    
    for i = 1:height
        for j = 1:width
            I1 = gray_imgs(n,i,j);
            I2 = de_img(1,i,j);
            
            M(i,j,n,1:3) = I1*L2 - I2*L1;
        end
    end
    

end

for i = 1:height
    for j = 1:width
        [U,S,V] = svd(reshape(M(i,j,:,:),[uniqueNum-1,3]),0);
        init_normals(i,j,1:3) = V(:,1);
        init_normals_pic(i,j) = dot(reshape(init_normals(i,j,1:3),[1,3]),lightVecs(I,1:3));
    end
end
