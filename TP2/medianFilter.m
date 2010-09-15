function ret = medianFilter2( img )
%MEDIANFILTER2 median 3x3 filter to img
%   Detailed explanation goes here

	% the return value type is the same as the entry image type
	ret = img;

	% process for RGB or RAW image
	if(length(size(img.full)) == 3)
		ret.R = uint8(nlfilter(double(ret.R), [3, 3], @medianFunc));
		ret.G = uint8(nlfilter(double(ret.G), [3, 3], @medianFunc));
		ret.B = uint8(nlfilter(double(ret.B), [3, 3], @medianFunc));

		ret.full = ret.R;
		ret.full(:,:,2) = ret.G;
		ret.full(:,:,3) = ret.B;
	else
		ret.full = uint8(nlfilter(double(ret.full), [3, 3], @medianFunc));
	end
end

function result = medianFunc(x)

for i = 1 : 3
    for j = 1 : 3
            medianVector(i * j) = x(i,j);
    end
end

result = median(medianVector);

end