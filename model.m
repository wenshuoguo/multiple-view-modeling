function surface = model(rNorms, texture)

<<<<<<< HEAD
%reconstruct depth surface 
=======
 %reconstruct depth surface 
>>>>>>> 68f82dded628ca699b9b8cd28f4b3fcae81bb385
 
 [nh, nw, ~] = size(rNorms);
 slant = zeros([nh nw]);
 tilt = zeros([nh nw]);
 for i = 1:nh
     for j = 1:nw
         n1 = rNorms(i,j,1);
         n2 = rNorms(i,j,2);
         n3 = rNorms(i,j,3);
         p = -n1/n3;
         q = -n2/n3;
         %calculate slant and tilt
         [slant(i,j), tilt(i,j)] = grad2slanttilt(p, q);
         
     end
 end
 surface = shapeletsurf(slant, tilt, 6, 1, 2);
 
<<<<<<< HEAD
%build 3d model
=======
 %build 3d model
>>>>>>> 68f82dded628ca699b9b8cd28f4b3fcae81bb385
 
[x, y] = meshgrid(1:nw, 1:nh);
figure('Name','Reconstructed Model'), ...
    h = surf(x,y,surface,'FaceColor',[0.498 0.816 0.922],'FaceAlpha',0.95,'EdgeColor','none');

<<<<<<< HEAD
%mapping with texture
=======
%mapping
>>>>>>> 68f82dded628ca699b9b8cd28f4b3fcae81bb385
imgTexFlip = zeros(size(texture));
for i = 1:3
    imgTexFlip(:,:,i) = flipud(texture(:,:,i));
end
set(h, 'CData', imgTexFlip, 'FaceColor', 'texturemap');

camlight left;
lighting phong;
axis vis3d;
daspect([max(daspect)*[1 1] 2.5]);
axis off; 
 
end