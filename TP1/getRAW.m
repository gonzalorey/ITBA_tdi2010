function ret = getRAW(filename, hight, width)
	ret.full = fread(fopen(filename, 'r'), [hight, width], 'uint8=>uint8')';
	ret.hight = hight;
	ret.width = width;
end