function ret = highFilter2(img, num)

	% exit if it's not odd
	if((mod(num,2)) == 0)
		fprintf('Only odd size filters\n');
	end
	
	% create the mask
	mask = ones(num, num) * -1;
	mask(ceil(num/2), ceil(num/2)) = num * num - 1;

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