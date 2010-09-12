function ret = runTP1(filename, hight, width)
	
	% load the image
	image = getRAW(filename, hight, width);
	ret.original = image;
	saveImage(image.full, 'original.jpg');
	
	% 1c Dynamic Range Compression
	ret.DRC = getDRC(image.full, 20);
	saveImage(ret.DRC, 'DRC.jpg');
	
	% b Negative
	ret.negative = getNegative(image.full);
	saveImage(ret.negative, 'negative.jpg');
end
