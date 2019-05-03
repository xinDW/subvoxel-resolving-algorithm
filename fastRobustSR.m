function fastRobustSR(lr_set, psf, lr_voxel_lateral, ls_thickness, scan_step, off_axis, factor, regularization)
%%  Fast Robust Super Resolution
% resolution enhancement is broken into 2 consecutive steps
%   1) noniterative data fusion(pixelwise median or pixelwise mean);
%   2) iterative deblurring-interpolation.
%
% Parames:
%    -ls_thickness: the width (um) of light sheet,measured by FWHM
%    -factor: [xy_factor, z_factor], enhancement factor
%    -regularization: if true, add regularization during optimizing

xy_step = scan_step * sin(deg2rad(off_axis));
z_step = sqrt((scan_step * cos(deg2rad(off_axis)))^2 - (xy_step)^2);

factor_xy = factor(1);
factor_z = factor(2);

lr_num = length(lr_set);

beta = 0.3;
lambda = 0.009;
alpha = 0.7;
P = 2;
iter_times = 50;

xy_shift_pixel = xy_step / lr_voxel_lateral ;

shift_xy = 0: xy_shift_pixel : (lr_num-1)*xy_shift_pixel;
shift_z = zeros(1,lr_num);

for i = 1 : lr_num
    shift_z(i) = (i-1) * z_step / ls_thickness;
end

save_dir = 'image/SR/fastRobustSR/';
if ~exist(save_dir, 'dir')
    mkdir(save_dir);
end


width  = size(lr_set{1},1);
height = size(lr_set{1},2);
lr_depth = size(lr_set{1},3);

lr_interp = zeros(width*factor_xy, height*factor_xy,lr_depth* factor_z, lr_num);
%Z = resize3D(lr_set{1},width*xy_enhan_factor,height*xy_enhan_factor,lr_depth*z_enhan_factor);

for i = 1 : lr_num
    lr_shift  = shift3D(lr_set{i},-shift_xy(i),-shift_xy(i),-shift_z(i));
    lr_interp(:,:,:,i) = resize3D(lr_shift, width * factor_xy, height * factor_xy, lr_depth * factor_z);
end

Z = median(lr_interp,4);

iter = 1;
errList = 0;
%X = zeros(width*xy_enhan_factor,height*xy_enhan_factor,lr_depth* z_enhan_factor);
X = Z;
sharpen = [0 -0.25 0;...
    -0.25 2 -0.25;...
    0 -0.25 0];
while iter < iter_times
    fprintf('iteration %d \t', iter);
    tic
    regular_factor = zeros(width*factor_xy,height*factor_xy,lr_depth* factor_z);
    X_pre = X;
    temp = imfilter(X,psf);
    temp = temp - Z;
    %temp = sign(temp);
    
    %temp = deconvlucy(temp,psf);
    temp = imfilter(temp,sharpen);
    
    if regularization
        for l = -P : P
            for m = 0 : P
                if (l + m) > 0
                    regular_factor = regular_factor + power(alpha,abs(l)+abs(m))*((X - shift3D(X,l,m,0)) - shift3D((X - shift3D(X,l,m,0)),-l,-m,0));
                end
            end
        end
    end
    
    X = X - beta*(temp + lambda * regular_factor );
    %X = X - beta*temp;
    write3d(X,sprintf('%siter_%02d.tif', save_dir, iter));
    toc
    dist = X_pre - X;
    dist_norm = 0;
    for i = 1 : factor_z : lr_depth * factor_z
        dist_norm = dist_norm + norm(dist(:,:,i));
    end
    errList = [errList , dist_norm];
        
    if iter > 3
        fprintf('error : %.3f\n', (errList(iter - 1) - errList(iter)));
        if (errList(iter - 1) - errList(iter)) < 10
            break;
        end
    end
    
    iter = iter + 1;
end


