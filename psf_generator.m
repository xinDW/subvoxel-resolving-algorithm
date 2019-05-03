function psf = psf_generator(xyImprove, zImprove, theta, xySensor, zSensor )


gensize = 51; % Maximum X,Y,Z pixel size during generation
cropthershold = 2000; % crop psf while pixel index is less than cropthershold (maximun = 65535)

%theta = 5;     %scan theta, XZ_angle
%xySensor = 6.5/4;
%zSensor = 2;  %half width of light sheet

%% Compute filter size
xyReal = xySensor*2;
zReal = zSensor*2;
xyGrid = xyReal/(xySensor/xyImprove);
zGrid = zReal/(zSensor/zImprove);
xySigma = xyGrid/2-1;
if xySigma < 1
    xySigma = 1;
end
zSigma = zGrid/2-1;
if zSigma < 1
    zSigma = 1;
end

%% Generate filter slices
xyH = fspecial('gaussian', [gensize gensize], xySigma);
% imshow(xyH, []);
xyH = xyH * (65535/max(xyH(:)));
% zHLine = fspecial('gaussian', [1 gensize+1], zSigma);
zline = besselj(0, 1 : floor(gensize / 2));

zHLine = [flip(zline) zline];
zHLine(zHLine < 0) = 0;

zHLine = zHLine * (65535/max(zHLine(:)));

h = zeros(gensize, gensize, gensize);
for i = 1: size(zHLine, 2)
    h(:,:,i) = xyH * zHLine(i);
end

h = h * (65535/max(h(:)));


%% Clip
psf = uint16(h);
sx = gensize;
sy = gensize;
sz = gensize;
psfm = psf(:,:,round(sz/2));
xcrop1 = 0;
for i=1:round(sx/2)
    if( max(psfm(i,:))<= cropthershold)
        xcrop1 = i;
    end
end
xcrop1 = xcrop1+1;

xcrop2 = gensize;
for i=round(sx/2):sx
    if( max(psfm(i,:)) > cropthershold)
        xcrop2 = i;
    end
end

xcrop1 = min(xcrop1, (gensize - xcrop2 +1));
xcrop2 = gensize - xcrop1 + 1;


ycrop1 = 0;
for i=1:round(sy/2)
    if( max(psfm(:,i))<= cropthershold)
        ycrop1 = i;
    end
end
ycrop1 = ycrop1+1;

ycrop2 = gensize;
for i=round(sy/2):sy
    if( max(psfm(:,i))> cropthershold)
        ycrop2 = i;
    end
end

ycrop1 = min(ycrop1, (gensize - ycrop2 +1));
ycrop2 = gensize - ycrop1 + 1;

output = psf(xcrop1:xcrop2, ycrop1:ycrop2, :);
output1 = output;

zcrop1 = 0;
for i=1:round(sz/2)
    if(max(max(output1(:,:,i)))<= cropthershold)
        zcrop1 = i;
    end
end
zcrop1 = zcrop1 +1;

zcrop = gensize;
for i=round(sz/2):sz
    if(max(max(output1(:,:,i)))> cropthershold)
        zcrop2 = i;
    end
end

zcrop1 = min(zcrop1, (gensize - zcrop2 + 1));
zcrop2 = gensize - zcrop1 + 1;

output = output1(:,:, zcrop1:zcrop2);

psf = double(output);
psf = psf/(sum(psf(:)));

fprintf('[*] psf generated\n');