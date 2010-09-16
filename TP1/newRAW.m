function ret = newRAW(filename, A)
	%create the file
	fid = fopen(filename, 'wb');
	
	%write to disc with matrix A
	fwrite(fid, A);
	
	ret.full = A;
	ret.height = length(A(:,1));
	ret.width = length(A(1,:));
end