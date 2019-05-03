function robustSR3D(lr_set, shift_lateral, shift_axial, psf, factor_lateral, factor_axial, regularization)
%% Robust Super Resolution(median) Applied in 3D
% lr_num is the quantity of the generated low resolution image sets

width  = size(lr_set{1},1);
height = size(lr_set{1},2);
depth = size(lr_set{1},3);

lr_num = length(lr_set);

beta = 0.05;
lambda = 0.17;
alpha = 0.7;
iter_times = 50;

% X is the 3D matrix used as High resolution image sequence in iterations
%X = zeros(width*enhan_factor_lateral,height*enhan_factor_lateral,depth* enhan_factor_axial);
X = resize3D(lr_set{1}, width*factor_lateral, height*factor_lateral, depth*factor_axial);
gamma = X;

%%  iteration begins
iter = 0;
errArray = 0;

save_dir = 'image/SR/robustSR/';
if ~exist(save_dir, 'dir')
    mkdir(save_dir);
end

while iter < iter_times
    iter = iter + 1;
    X_pre = X;
    
    %diff = zeros(width,height,depth,lr_num);
    diff = zeros(width,height,depth);
    
    fprintf('[*] Iteration %d ',iter);
    tic
    for k = 1 : lr_num
        
        % shift X
        tmp  = shift3D(X,shift_lateral(k)*factor_lateral, shift_lateral(k)*factor_lateral , shift_axial(k)*factor_axial);
        
        % downsample X to match Lr set
        tmp = tmp(1:factor_lateral:end,1:factor_lateral:end,1:factor_axial:end);
        %tmp = resize3D(tmp, width, height, depth);
        % blur X by convolution
        %tmp = imfilter(tmp,psf); 
        tmp = imgaussfilt3(tmp, 1);
        tmp = tmp - lr_set{k};
        tmp = sign(tmp);
        %tmp = imfilter(tmp,psf);
        %tmp = imgaussfilt3(tmp, 1);
        %diff(:,:,:,k) = shift3D(tmp,-shift_lateral(k),-shift_lateral(k),-shift_axial(k));
        diff = diff + shift3D(tmp, -shift_lateral(k), -shift_lateral(k), -shift_axial(k));
        fprintf('*');
    end
    
    % madian
    %diff_median =  median(diff,4);
    
    %interpolate
    diff = resize3D(diff,width*factor_lateral,height*factor_lateral,depth*factor_axial);
    
    if regularization
        gamma = 0 * gamma;
        for l = -2:2
            for m = -2:2
                for n = 0:2
                    S = sign(X - shift3D(X,l,m,n));
                    gamma = gamma + (alpha^(abs(l)+abs(m)+abs(n))) * (S - shift3D(S,-l,-m,-n));
                end
            end
        end
    end
    
    
    X = X - beta * (diff + lambda * gamma);
    fprintf('*\n');
    Error = X_pre - X;
    error_norm = 0;
    x_norm = 0;
    for i = 1 : 10 : size(Error,3)
        error_norm = error_norm + norm( Error(1:10:end,1:10:end,i));
        x_norm = x_norm + norm(X(1:10:end,1:10:end,i));
    end
    
    errArray = [errArray,error_norm/x_norm];
    
    toc
    fprintf('error to origin = %.5f', error_norm/x_norm);
    fprintf('\terror to last = %.5f\n',(errArray(iter) - (errArray(iter + 1))));
    
    % save rough images
    filename = sprintf('%siter_%02d.tif', save_dir, iter);
    write3d(X,filename);
    
    if iter > 5
        if errArray(iter) - errArray(iter + 1) < 1e-2
            break;
        end
    end
end
fprintf('[!] Done\n');    







