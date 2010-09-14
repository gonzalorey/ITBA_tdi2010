function ret = rectangularMask( img, mask )
%RECTANGULARMASK Summary of this function goes here
%   Detailed explanation goes here

ret.R = uint8(matrixMask(double(img.R), mask));
ret.G = uint8(matrixMask(double(img.G), mask));
ret.B = uint8(matrixMask(double(img.B), mask));
ret.full = ret.R;
ret.full(:,:,2) = ret.G;
ret.full(:,:,3) = ret.B;




function ret = matrixMask(img, mask)
iImgSize = size(img,1);
jImgSize = size(img,2);

for i = 1 : iImgSize
    for j = 1 : jImgSize
        ret(i,j) = neighbors(img,i,j,mask);
    end
end
      





function ret = neighbors( img, i, j, mask)

maskSize = (size(mask,1) - 1) / 2;
iImgSize = size(img,1);
jImgSize = size(img,2);

partial = 0;

for x = -1 * maskSize : maskSize
    for y = -1 * maskSize : maskSize
        if (( i + x ) >= 1)  && (( i + x ) <= iImgSize)  && (( j + y) >= 1) && ((j + y) <= jImgSize)
            partial = partial + mask(x + maskSize + 1, y + maskSize + 1) * img(i + x,j + y);
        end
    end
end

ret = partial;