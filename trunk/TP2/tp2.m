function ret = tp2(A)
	% save the original
	ret.orig = A;
	
	% gaussian additive white noise
	ret.gau = gaussianNoise(ret.orig, 0, 15);
	saveImage(ret.gau, 'gaussian.jpg');
	
	% rayleigh multiplicative noise
	ret.ray = rayleighNoise(ret.orig, 1);
	saveImage(ret.ray, 'rayleigh.jpg');
	
	% exponential multiplicative noise
	ret.exp = exponentialNoise(ret.orig, 10);
	saveImage(ret.exp, 'exponential.jpg');
	
	% salt & pepper noise
	ret.sap = saltAndPepperNoise(ret.orig, 0.05, 0.95);
	saveImage(ret.exp, 'salt&pepper.png');
	
	% show the results
	imshow([ret.orig, ret.orig, ret.orig, ret.orig; ret.gau, ret.ray, ret.exp, ret.sap]);
	saveImage([ret.orig, ret.orig, ret.orig, ret.orig; ret.gau, ret.ray, ret.exp, ret.sap], 'full.bmp');
	
end

