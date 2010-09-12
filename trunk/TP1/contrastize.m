function ret = getContrastized(A, r1, r2)

	% get the matrix for the values lower than r1
	Ar1 = cast(A <= r1, 'uint8') .* A .* 1/4;
	
	% get the matrix for the values greater than r2
	Ar2 = cast(A >= r2, 'uint8') .* A .* 3/4 + 63.75;
	Ar2 = cast(Ar2 > 63.75, 'uint8') .* Ar2;
	
	% get the rest of the matrix without any convertion
	Af = cast(A > r1 & A < r2, 'uint8') .* A;
	
	% sum all the matrixes
	ret = Ar1 + Ar2 + Af;
		
end

