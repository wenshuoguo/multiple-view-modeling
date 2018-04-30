function surface = model(rNorms, texture)

 [nh, nw, ~] = size(rNorms);
 slant = zeros([nh nw]);
 tilt = zeros([nh nw]);
 for i = 1:nh
     for j = 1:nw
         [n1,n2,n3] = nNorms(i,j,1:3);
         p = -n1/n3;
         q = -n2/n3;
         %slant and tilt
         [slant(i,j), tilt(i,j)] = grad2slanttilt(-n1/n3, -n2/n3);
         
     end
 end
 surface = shapeletsurf(slant, tilt, 6, 1, 2);
 
 
 
end