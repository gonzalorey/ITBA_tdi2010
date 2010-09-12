function ret = getImageMultiplication( A , B )

	% firt multiply the images
	ret = double(A) .* double(B);
	
	maxValue = max(max(ret));
	
	% normalize the result
	ret = ret / maxValue * 255;
	
	ret = uint8(ret);

end