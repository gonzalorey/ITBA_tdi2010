function ret = rayleighGenerator(psi, height, length)
	
	% get x~U(0,1)
	x = uniformGenerator(height, length);
	
	% get the matrix with rayleigh distribution y~R(psi)
	ret = psi * sqrt(-2 * log(1 - x));
end

