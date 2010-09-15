function ret = exponentialNoise(img, lambda)
	
	% the return value type is the same as the entry image type
	ret = img;
	
	% process for RGB or RAW image
	if(length(size(ret.full)) == 3)
		% get the noise with the exponential distribution generator
		noise = exponentialGenerator(lambda, size(ret.R,1), size(ret.R,2));
		
		% sum the images and the noise
		ret.R = imageMultiplication(ret.R, noise);
		ret.R = uint8(ret.R);
		ret.G = imageMultiplication(ret.G, noise);
		ret.G = uint8(ret.G);
		ret.B = imageMultiplication(ret.B, noise);
		ret.B = uint8(ret.B);
		ret.full = ret.R;
		ret.full(:,:,2) = ret.G;
		ret.full(:,:,3) = ret.B;
	else
		% get the noise with the exponential distribution generator
		noise = exponentialGenerator(lambda, ret.height, ret.width);

		% multiply the image and the noise
		ret.full = imageMultiplication(ret.full, noise);

		% cast and return
		ret.full = uint8(ret.full);
	end
end

