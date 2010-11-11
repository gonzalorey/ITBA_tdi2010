% get the Dynamic Range Compression of an image A with c
function ret = getInverseDRC(originalModule, A)

	MIN = min(min(originalModule));
	MAX = log(originalModule - MIN + 1);

	ret = exp((double(A) .* MAX) / 255) + MIN - 1;
end