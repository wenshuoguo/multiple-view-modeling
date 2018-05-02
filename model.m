function surface = model(rNorms, texture)

%original
 [nh, nw, ~] = size(rNorms);
 s = size(rNorms);
 slant = zeros(s(1:2));
 tilt = zeros(s(1:2));
 for i = 1:nh
     for j = 1:nw
       idx = squeeze(rNorms(nh+1-i,j,:));
%       disp(n_ij);
        p = -idx(1)/idx(3);
        q = -idx(2)/idx(3);
        
        %calculate slant and tilt
        [slant(i,j), tilt(i,j)] = grad2slanttilt(p, q);
         
      end
 end
surface = shapeletsurf(slant, tilt, 6, 1, 2);

%build 3d model

[x, y] = meshgrid(1:nw, 1:nh);
figure('Name','Reconstructed Model'), ...
    h = surf(x,y,surface,'FaceColor',[0.497 0.815 0.921],'FaceAlpha',0.95,'EdgeColor','none');

%mapping with texture

imgTexFlip = zeros(size(texture));
 for i = 1:3
     imgTexFlip(:,:,i) = flipud(texture(:,:,i));
 end
set(h, 'CData', imgTexFlip, 'FaceColor', 'texturemap');

camlight left;
lighting phong;
axis vis3d;

%daspect([3 1 1]);
daspect([max(daspect)*[1 1] 2.5]);
axis off; 
 
end