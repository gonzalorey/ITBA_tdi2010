function ret = gaussianNoise(img, mu, sigma)

	% the return value type is the same as the entry image type
	ret = img;
	
	% process for RGB or RAW image
	if(length(size(ret.full)) == 3)
		% get the noise with the exponential distribution generator
		noise = gaussianGenerator(mu, sigma, size(ret.R,1), size(ret.R,2));
		
		% sum the images and the noise
		ret.R = imageSum(ret.R, noise);
		ret.R = uint8(ret.R);
		ret.G = imageSum(ret.G, noise);
		ret.G = uint8(ret.G);
		ret.B = imageSum(ret.B, noise);
		ret.B = uint8(ret.B);
		ret.full = ret.R;
		ret.full(:,:,2) = ret.G;
		ret.full(:,:,3) = ret.B;
	else
		% get the noise with the exponential distribution generator
		noise = gaussianGenerator(mu, sigma, ret.height, ret.width);

		% multiply the image and the noise
		ret.full = imageSum(ret.full, noise);

		% cast and return
		ret.full = uint8(ret.full);
	end
end

