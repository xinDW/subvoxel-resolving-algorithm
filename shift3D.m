function shiftMtx = shift3D(Im, X_shift, Y_shift, Z_shift)
%shift3D Shift a matrix in 3D. Pads with zeros.
% .........................../------------->   Y-axis
%........................../ |
%..............X-axis /   |
% ...........................|
% ...........................V     Z-aixs

%   Im - 3D matrix
%   shift vector : positive value means shift towards the positive direction...
%   of the axis

%  Modifiey on 10-18-2016
[Y_res,  X_res, Z_res] = size(Im);
X_int = floor(X_shift);
Y_int = floor(Y_shift);
Z_int = floor(Z_shift);
X_dec = X_shift - X_int;
Y_dec = Y_shift - Y_int;
Z_dec = Z_shift - Z_int;
% note that while x_shift >0, like 0.3, x_dec = 0.3 as well;
% but while x_shift < 0, like -0.3,  x_dec = 0.7 instead of 0.3

X_shifted = zeros(size(Im));

if X_shift > 0 || X_shift == 0
    
    % perform interger part of shift
    X_shifted(:, (X_int + 1) : end, :) = Im(:, 1 : (X_res - X_int), :);
    %perform decimal part of shift
    X_shifted(:, 2:end, :) = X_shifted(:, 2:end, :) * (1 - X_dec) + X_shifted(:, 1:(end-1), :)*X_dec ;
    X_shifted(:, 1, :) =  X_shifted(:, 1, :) * (1 - X_dec);
else
    
    X_int = X_int + 1; 
    % to prevent occasion like : x_shift = -0.5, while x_int = floor(x_shift) =...
    % -1, which should be 0 actually. Still note that x_shift = -1, x_int =...
    % -1,  x_int + 1 = 0, means that the integer part of shift is zero. But this can be...
    % fixed by this:
    X_shifted(:, 1 : (X_res + X_int),:) = Im(:,(1 - X_int) : end, :);
    X_shifted(:, 1:end-1, :) = X_shifted(:, 1:end-1, :) * (X_dec) + X_shifted(:, 2:end, :)*( 1 - X_dec) ; 
    X_shifted(:, X_res, :) =  X_shifted(:, X_res, :) * ( X_dec);
end

Y_shifted = zeros(size(Im));
if Y_shift > 0 ||  Y_shift == 0
    
    Y_shifted((Y_int + 1) : end, :, :) = X_shifted(1 : (Y_res - Y_int),: ,:);
    Y_shifted(2:end, :, :) = Y_shifted(2:end, :, :) * (1 - Y_dec) + Y_shifted(1:end-1, :, :) * Y_dec;
    Y_shifted(1, :, :) = Y_shifted(1, :, :) * (1 - Y_dec);
else
    
    Y_int = Y_int +1;
    Y_shifted(1 : (Y_res + Y_int), :, :) = X_shifted((1 - Y_int) : end, :, :);
    Y_shifted(1:end-1, :, :) = Y_shifted(1:end-1, :, :) * Y_dec + Y_shifted(2:end, :, :) * (1 - Y_dec);
    Y_shifted(end, :, :) = Y_shifted(end, :, :) * Y_dec;
    
end

clear X_shifted;
Z_shifted = zeros(size(Im));
if  Z_shift > 0 || Z_shift == 0 
     Z_shifted(:, :, (Z_int + 1 : end)) = Y_shifted(:, :, 1 : (Z_res - Z_int));   
     Z_shifted(:, :, 2:end) = Z_shifted(:, :, 2:end) * (1 - Z_dec) + Z_shifted(:, :, 1:end-1) * Z_dec;
     Z_shifted(:, :, 1) = Z_shifted(:, :, 1) * (1 - Z_dec);
else
    Z_int = Z_int + 1;
    Z_shifted(:, :, 1  : (Z_res + Z_int)) = Y_shifted(:, :, (1 - Z_int) : end);
    Z_shifted(:, :, 1:end-1) = Z_shifted(:, :, 1:end-1) * Z_dec + Z_shifted(:, :, 2:end) * (1 - Z_dec);
    Z_shifted(:, :, end) = Z_shifted(:, :, end) * Z_dec;
end

clear Y_shifted;
shiftMtx = Z_shifted;
end
