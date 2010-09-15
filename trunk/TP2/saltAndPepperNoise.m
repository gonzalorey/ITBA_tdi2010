function ret = saltAndPepperNoise(img, p0, p1)
	
	% the return value type is the same as the entry image type
	ret = img;
	
	% process for RGB or RAW image
	if(length(size(ret.full)) == 3)
		% get the noise with the salt & pepper distribution generator
		noise = saltAndPepperGenerator(p0, p1, size(ret.R,1), size(ret.R,2));
		
		% sum the images and the noise
		ret.R = ret.R .* uint8(noise == 1) + noise .* uint8(noise ~= 1);
		ret.R = uint8(ret.R);
		ret.G = ret.G .* uint8(noise == 1) + noise .* uint8(noise ~= 1);
		ret.G = uint8(ret.G);
		ret.B = ret.B .* uint8(noise == 1) + noise .* uint8(noise ~= 1);
		ret.B = uint8(ret.B);
		ret.full = ret.R;
		ret.full(:,:,2) = ret.G;
		ret.full(:,:,3) = ret.B;
	else
		% get the noise with the salt & pepper distribution generator
		noise = saltAndPepperGenerator(p0, p1, ret.height, ret.width);

		% multiply the image and the noise
		ret.full = ret.full .* uint8(noise == 1) + noise .* uint8(noise ~= 1);

		% cast and return
		ret.full = uint8(ret.full);
	end
end

