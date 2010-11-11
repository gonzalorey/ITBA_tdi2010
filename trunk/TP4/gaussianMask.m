function ret = gaussianMask(height, width, sigma)
	[x, y] = meshgrid(-height:width, -height:width);
	ret = 1 / (2*pi * sigma*sigma) * exp(-(x .* x + y .* y) / (sigma*sigma));
end