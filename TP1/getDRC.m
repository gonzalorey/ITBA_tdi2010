% get the Dynamic Range Compression of an image A with c
function ret = getDRC(A, c)
	
	% cast the variable to double so I can use it with log
	auxA = cast(A, 'double');
	
	% apply the DRC function
	auxA = c * log(auxA + 1);
	
	% cast again to uint8
	ret = cast(auxA, 'uint8');
end