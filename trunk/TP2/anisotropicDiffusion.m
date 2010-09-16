function ret = anisotropicDiffusion(img, sigma, dim, cn, cs, ce, cw)
	
	% the return value type is the same as the entry image type
	ret = img;
	
	% create the mask
	mask = [0, sigma * cn, 0; sigma * ce, 1, sigma * cw; 0, sigma * cs, 0];
	mask = mask / sum(sum(mask));
	ret.mask = mask;

	% process for RGB or RAW image
	if(length(size(img.full)) == 3)
		ret.R = applyMask(img.R, mask);
		ret.G = applyMask(img.G, mask);
		ret.B = applyMask(img.B, mask);
		ret.full = ret.R;
		ret.full(:,:,2) = ret.G;
		ret.full(:,:,3) = ret.B;
	else
		ret.full = applyMask(ret.full, mask);
	end
end