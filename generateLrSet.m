function lr_set = generateLrSet(sample,lr_set_num,lay_interval) 
%% Generate lR image sets
% Divide the acquired raw image sequence into multiple low resoltion (LR)
% image sets with axial sampling rate equal to half of the FWHM of the
% light sheet
%
% sample -- the acquired raw image(heart_example.tif)
% width/height/depth -- three dimension of the acquired raw image sequence
% lr_set_num  -- quantity of  LR sets
% lay_interval -- interval  between layers of a lr set,equals light sheet
%  width* 0.5 /(axis component of scan step)

depth = size(sample,3);
num_rem = rem(depth,lr_set_num);
%depth = depth - num_rem;
depth_temp = depth;

save_dir = 'image/LR/';
if ~exist(save_dir, 'dir')
    mkdir(save_dir);
end

lr_set = {};
for i = 0 : (lr_set_num-1)
    k = lr_set_num - i;
    for j = k  :  lay_interval  : depth_temp
        if j == k
            lr_set{k} = sample(:,:,j);
        end
        lr_set{k} = cat(3,lr_set{k},sample(:,:,j));
    end
    depth_temp = j;
end

for i = 1:lr_set_num
    lr_name = sprintf('%s%02d.tif', save_dir, i);
    write3d(lr_set{i}, lr_name);
end

[h, w, d] = size(lr_set{1});
fprintf('[*] %d LRs in size [%d %d %d] created\n', lr_set_num, h, w, d);