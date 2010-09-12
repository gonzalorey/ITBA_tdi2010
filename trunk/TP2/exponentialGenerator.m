function ret = exponentialGenerator(lambda, height, length)
	
	% get x~U(0,1)
	x = uniformGenerator(height, length);
	
	% get the noise matrix
	ret = -log(x) / lambda + 0.5;
end

