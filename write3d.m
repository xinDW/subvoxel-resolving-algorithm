function write3d(image, name)
%WRITE3D writes given 3D image to given file name
%   Inputs:
%       image - 3D image stack
%       name - file name string
%       bitdepth - 8 or 16

%   Temporary : image2wt - the matrix used to write a tif image,in case
%   that the original image is changed.
image = abs(image);
max_val = max(image(:));
image2wt  = image * 65535/max_val;
image2wt = uint16(image2wt);
    
imwrite((image2wt(:,:,1)), name);

for i = 2:size(image2wt, 3)
    imwrite((image2wt(:,:,i)), name,  'WriteMode', 'append');
end


