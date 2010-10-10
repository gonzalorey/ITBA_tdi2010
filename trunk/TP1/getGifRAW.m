function ret = getGifRGB(filename)
	ret.full = imread(filename);
    ret.height = size(ret.full, 1);
    ret.width = size(ret.full, 2);
end