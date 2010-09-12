function ret = saltAndPepperNoise(A, p0, p1)
	
	% get the noise with the salt & pepper distribution generator
	noise = uint8(saltAndPepperGenerator(p0, p1, length(A(:,1)), length(A(1,:))));
	
	% multiply the image and the noise
	ret = A .* uint8(noise == 1) + noise .* uint8(noise ~= 1);
	
	% cast and return
	ret = uint8(ret);
end

