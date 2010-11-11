function ret = resizeMask(height, width, mask)
	ret.height = height;
	ret.width = width;
	ret.full = zeros(height, width);
	ret.full(1:size(mask,1) , 1:size(mask,2)) = mask;
end