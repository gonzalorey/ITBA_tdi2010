function ret = medianFilter(img)

	mask1 = [-1, -1, -1; 0, 0, 0; 1, 1, 1];
	mask2 = [-1, 0, 1; -1, 0, 1; -1, 0, 1];

	% process for RGB or RAW image
	if(length(size(img.full)) == 3)
		ret.R = applyMask(img.R, mask1);
		ret.R = imageSum(ret.R, applyMask(img.R, mask2));
		ret.G = applyMask(img.G, mask1);
		ret.G = imageSum(ret.G, applyMask(img.G, mask2));
		ret.B = applyMask(img.B, mask1);
		ret.B = imageSum(ret.B, applyMask(img.B, mask2));
		ret.full = ret.R;
		ret.full(:,:,2) = ret.G;
		ret.full(:,:,3) = ret.B;
	else
		ret = img;
		ret.full = applyMask(ret.full, mask1);
		ret.full = imageSum(ret.full, applyMask(ret.full, mask2));
	end
end