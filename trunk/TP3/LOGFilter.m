function ret = LOGFilter(img, sigma, dim)
	
	% the return value type is the same as the entry image type
	ret = img;
	
	% FILMINA 32!!!!
	dim = (dim - 1) / 2;
	[x, y] = meshgrid(-dim:dim, -dim:dim);

	LOG = -1 / (sqrt(2*pi) * sigma*sigma*sigma) * (2 - (x.*x + y.*y) / (sigma*sigma)) .* exp(-(x.*x + y.*y) / (2*sigma*sigma));
	
	% normalize it...
	mask = LOG / sum(sum(LOG));
	ret.LoG = mask;
	
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