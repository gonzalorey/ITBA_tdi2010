function ret = saltAndPepperGenerator(p0, p1, height, length)
	
	% get x~U(0,1)
	x = uniformGenerator(height, length);
	
	% put the salt
	ret = x > p0;
	
	% add the pepper
	ret = ret + (x >= p1) * 254;
	
	% cast
	ret = uint8(ret);
end

