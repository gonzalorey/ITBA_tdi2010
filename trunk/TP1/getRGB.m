function ret = getRGB(filename)
	ret.full = imread(filename);
	ret.R = ret.full(:,:,1);
	ret.G = ret.full(:,:,2);
	ret.B = ret.full(:,:,3);
	ret.fullR = getFullR(ret);
	ret.fullG = getFullG(ret);
	ret.fullB = getFullB(ret);	
end

function ret = getFullR(img)
	ret = img.full;
	ret(:,:,2) = 0;
	ret(:,:,3) = 0;
end

function ret = getFullG(img)
	ret = img.full;
	ret(:,:,1) = 0;
	ret(:,:,3) = 0;
end

function ret = getFullB(img)
	ret = img.full;
	ret(:,:,1) = 0;
	ret(:,:,2) = 0;
end