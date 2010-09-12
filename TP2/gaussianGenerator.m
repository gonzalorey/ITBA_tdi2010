function ret = gaussianNoise(mu, sigma2, height, length)
	
	% N(mean, sigma^2) = N(0,1)*sigma2 + mu
	
	% get x1~U(0,1)
	x1 = uniformGenerator(height, length);
	
	% get x2~U(0,1)
	x2 = uniformGenerator(height, length);
	
	% get y1~N(0,1)
	y1 = sqrt(-2 * log(x1)) .* cos(2 * pi * x2);
	
	% get y2~N(0,1)
	y2 = sqrt(-2 * log(x1)) .* sin(2 * pi * x2);
	
	% sum y1~N(mu, sigma2) + y2~N(mu, sigma2)
	ret = y1*sigma2+mu + y2*sigma2+mu;
end

