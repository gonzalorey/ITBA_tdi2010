function ret = gaussianNoise(A, mu, sigma)
	
	% get the noise with the exponential distribution generator
	noise = gaussianGenerator(mu, sigma, length(A(:,1)), length(A(1,:)));
	
	% multiply the image and the noise
	ret = imageSum(A, noise);
	
	% cast and return
	ret = uint8(ret);
end

