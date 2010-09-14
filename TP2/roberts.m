function ret = roberts(img)

	mask1 = [1, 0; 0, -1];
	mask2 = [0, 1; -1, 0];

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
		ret.full = applyMask(ret.full, mask1);
		ret.full = imageSum(ret.full, applyMask(ret.full, mask2));
	end
end