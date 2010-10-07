function ret = getThreshold(img, threshold)
	
	% the return value type is the same as the entry image type
	ret = img;
	
	% process for RGB or RAW image
	if(length(size(img.full)) == 3)
		ret.R = ret.R > threshold;
		ret.G = ret.G > threshold;
		ret.B = ret.B > threshold;
		ret.full = ret.R;
		ret.full(:,:,2) = ret.G;
		ret.full(:,:,3) = ret.B;
	else
		ret.full = ret.full > threshold;
	end
end

