function ret = lowFilter( img, size )
%LOWFILTER low-pass filter applied to img, with a mask of size x size

if (size == 3)
    filter = @func3x3;
else
    size = 5;
    filter = @func5x5;
end

ret.R = uint8(nlfilter(double(img.R), [size, size], filter));
ret.G = uint8(nlfilter(double(img.G), [size, size], filter));
ret.B = uint8(nlfilter(double(img.B), [size, size], filter));

ret.full = ret.R;
ret.full(:,:,2) = ret.G;
ret.full(:,:,3) = ret.B;

function result = func3x3(x)
partialResult = 0;

for i = 1 : 3
    for j = 1 : 3
        partialResult = partialResult + x(i,j);
    end
end

result = 1/9 * partialResult;

function result = func5x5(x)
partialResult = 0;

for i = 1 : 5
    for j = 1 : 5
        partialResult = partialResult + x(i,j);
    end
end

result = 1/25 * partialResult;