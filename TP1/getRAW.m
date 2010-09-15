function ret = getRAW(filename, height, width)
	ret.full = fread(fopen(filename, 'r'), [height, width], 'uint8=>uint8')';
	ret.height = height;
	ret.width = width;
end