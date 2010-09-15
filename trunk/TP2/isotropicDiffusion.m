function ret = isotropicDiffusion(img, sigma, dim)
	
	% An image convolutioned throwgh a gaussian filter
	ret = gaussianFilter(img, sigma, dim);
end