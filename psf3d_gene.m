function [psf_hr,psf_lr] = psf3d_gene(voxel_size_lateral, HW, rsEnhanFactor)

%% generate a 3D point spread function accroding to microscope system parameter
% ccdSize - size of CCD ,in micron (6.5 um ,etc.)
% magFactor - magnification factor of microscope objective lens
% NA - numerical aperture of microscope  objective lens
% HW - full width at half maximum of light sheet ,
% rsEnhancefactor = [xy_enhan_factor  z_enhan_factor]  -  enhancement factor  in robust SR algorithm,which is
% used to compute a psf for HR image(i.e.,X).

%Note that in RobustSR iteration ,X is shifted ,blured,and downsampled.When
%blur operation is ahead of downsampling,the psf used in imfliter() function should be psf_hr. 

%real size of psf
xy_size = voxel_size_lateral * 2.5;
z_size = HW * 2.5 * 1.2;

xy_enhan_factor = rsEnhanFactor(1);
z_enhan_factor = rsEnhanFactor(2);

% quantity of lr voxels inside the point spreading zone (volume of a psf in the 3d space)
xy_lr_grid = round(xy_size / voxel_size_lateral);
z_lr_grid = round(z_size / HW);

% quality of hr voxels inside a psf volume
xy_hr_grid = round(xy_lr_grid * xy_enhan_factor);
z_hr_grid = round(z_lr_grid * z_enhan_factor);
xy_sigma = xy_hr_grid / 2;
z_sigma = z_hr_grid / 2;

psf_hr_center_slide = fspecial('gaussian',xy_hr_grid,xy_sigma);
psf_hr_center_line = fspecial('gaussian',[1,z_hr_grid],z_sigma); % max value of each slide

psf_hr = zeros(xy_hr_grid,xy_hr_grid,z_hr_grid);
for i = 1 : z_hr_grid
    psf_hr(:,:,i) = psf_hr_center_slide * psf_hr_center_line(i);
end

psf_hr = psf_hr/(sum(psf_hr(:)));
write3d(psf_hr,'psf_hr.tif');

psf_lr_center_slide = fspecial('gaussian',xy_lr_grid,xy_sigma/xy_enhan_factor);
psf_lr_center_line = fspecial('gaussian',[1,z_lr_grid],z_sigma/z_enhan_factor); % max value of each slide

psf_lr = zeros(xy_lr_grid,xy_lr_grid,z_lr_grid);
for i = 1 : z_lr_grid
    psf_lr(:,:,i) = psf_lr_center_slide * psf_lr_center_line(i);
end

psf_lr = psf_lr/(sum(psf_lr(:)));
write3d(psf_lr,'psf_lr.tif');


