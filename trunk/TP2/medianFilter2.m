function ret = medianFilter2( img )
%MEDIANFILTER2 median 3x3 filter to img
%   Detailed explanation goes here

ret.R = uint8(nlfilter(double(img.R), [3, 3], @medianFunc));
ret.G = uint8(nlfilter(double(img.G), [3, 3], @medianFunc));
ret.B = uint8(nlfilter(double(img.B), [3, 3], @medianFunc));

ret.full = ret.R;
ret.full(:,:,2) = ret.G;
ret.full(:,:,3) = ret.B;

end

function result = medianFunc(x)

for i = 1 : 3
    for j = 1 : 3
            medianVector(i * j) = x(i,j);
    end
end

result = median(medianVector);

end