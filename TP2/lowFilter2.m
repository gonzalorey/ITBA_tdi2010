function ret = lowFilter2(img, num)
	
	% the return value type is the same as the entry image type
	ret = img;
	
	% create the mask
	mask = ones(num, num) / (num * num);

	% process for RGB or RAW image
	if(length(size(img.full)) == 3)
		ret.R = applyMask(img.R, mask);
		ret.G = applyMask(img.G, mask);
		ret.B = applyMask(img.B, mask);
		ret.full = ret.R;
		ret.full(:,:,2) = ret.G;
		ret.full(:,:,3) = ret.B;
	else
		ret = img;
		ret.full = applyMask(ret.full, mask);
	end
end