function ret = highFilter( img, size )
%HIGHFILTER high-pass filter applied to img, with a mask of size x size

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
        if i == 2 && j == 2
            partialResult = partialResult + 8 * x(i,j);
        else
            partialResult = partialResult - x(i,j);
        end
    end
end

result = partialResult;

function result = func5x5(x)
partialResult = 0;

for i = 1 : 5
    for j = 1 : 5
        if i == 3 && j == 3
            partiaResult = partialResult + 32 * x(i,j);
        elseif (i == 2 && j > 1 && j < 5 ) || (j == 2 && i > 1 && i < 5)
            partialResult = partialResult - 2 * x(i,j);
        else
            partialResult = partialResult - x(i,j);
        end 
    end
end

result = partialResult;