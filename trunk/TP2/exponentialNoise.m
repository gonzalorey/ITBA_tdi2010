function ret = exponentialNoise(A, lambda)
	
	% get the noise with the exponential distribution generator
	noise = exponentialGenerator(lambda, length(A(:,1)), length(A(1,:)));
	
	% multiply the image and the noise
	ret = imageMultiplication(A, noise);
	
	% cast and return
	ret = uint8(ret);
end

