% get the Dynamic Range Compression of an image A with c
function ret = getDRC(A)

	% cast the variable to double so I can use it with log
	auxA = cast(A, 'double');
	
	% apply the DRC function
	auxA = log(auxA + 1);
    
    c = 255 / max(max(auxA));
	
	% cast again to uint8
	ret = cast(c * auxA, 'uint8');
end