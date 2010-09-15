function ret = gaussianFilter(img, sigma, dim)

	% the return value type is the same as the entry image type
	ret = img;
	
	% it should be distributed equally to the 0 coordinates and have dim elements
	dim = (dim - 1) / 2;
	
	% gauss...
	[x, y] = meshgrid(-dim:dim, -dim:dim);
	mask = 1 / (2*pi * sigma*sigma) * exp(-(x .* x + y .* y) / (sigma*sigma));
	
	% normalize it...
	mask = mask / sum(sum(mask));
	
	ret.mask = mask;

	% process for RGB or RAW image
	if(length(size(ret.full)) == 3)
		ret.R = applyMask(ret.R, mask);
		ret.G = applyMask(ret.G, mask);
		ret.B = applyMask(ret.B, mask);
		ret.full = ret.R;
		ret.full(:,:,2) = ret.G;
		ret.full(:,:,3) = ret.B;
	else
		ret.full = applyMask(ret.full, mask);
	end
end