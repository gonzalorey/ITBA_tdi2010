function ret = rayleighNoise(A, psi)
	
	% get the noise with the exponential distribution generator
	noise = rayleighGenerator(psi, length(A(:,1)), length(A(1,:)));
	
	% multiply the image and the noise
	ret = imageMultiplication(A, noise);
	
	% cast and return
	ret = uint8(ret);
end

