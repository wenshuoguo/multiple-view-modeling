function [ de_img,gray_imgs,I ] = find_denominator(imgs,L,H)
[height,width,chn,uniqueNum] = size(imgs);

gray_imgs = zeros(uniqueNum,height,width);
%convert the imgs to grey scale
for i=1:uniqueNum
    gray_imgs(i,:,:) = rgb2gray(uint8(imgs(:,:,:,i)));
end

pixels_rank = zeros(uniqueNum,height,width);
for h = 1:height
   for w = 1:width
       [B,I] = sort(gray_imgs(:,h,w),'ascend');
       [Lia,Locb] = ismember(gray_imgs(:,h,w),B);
       pixels_rank(:,h,w) = double(Locb/uniqueNum);
       
   end
end

k = zeros(uniqueNum,1);
r = zeros(uniqueNum,1);


for i=1:uniqueNum
    map = (pixels_rank(i,:,:)>L);
    k(i) = sum(map(:));
    map2 = (pixels_rank(i,:,:).*map);
    r(i) = double(sum(map2(:))/(k(i)));
end


c = k.*(r<H);

[M,I] = max(c(:));
disp(I)

de_img = imgs(:,:,:,I);

end

