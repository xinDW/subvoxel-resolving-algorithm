function imageStack = imread3D2(file)
%IMREAD3D2 Reads 3D TIFF stack
%   Inputs:
%       file - file name of TIFF stack
%       Width - X resolution of file
%       Height - Y resolution of file
%       Depth - number of slices in file

tiffInfo = imfinfo(file);
Width = tiffInfo(1).Width;
Height = tiffInfo(1).Height;
Depth = numel(tiffInfo);

imageStack = zeros(Height, Width, Depth);  % double by default
for i = 1:Depth
    %imageStack(:,:,i) = imread(file, 'Index', i, 'Info', tiffInfo);
    imageStack(:,:,i) = imread(file, i);
end
end