function ret = anisotropicDiffusion2(img, lambda, sigma, iterations)
	
	% the return value type is the same as the entry image type
	ret = img;
	
	if(length(size(ret.full)) == 3)        
        % apply for a RGB image		
		for k = 1 : iterations
			ret.R = applyNSWE(ret.R, lambda, sigma);				 
			ret.G = applyNSWE(ret.G, lambda, sigma);
			ret.B = applyNSWE(ret.B, lambda, sigma);
		end
		
		ret.full = ret.R;
	    ret.full(:,:,2) = ret.G;
	    ret.full(:,:,3) = ret.B;
	else		
		% apply for a raw image       
		for k = 1 : iterations	    
			ret.full = applyNSWE(ret.full, lambda, sigma);
		end
	end
	
end

function ret = applyNSWE(A, lambda, sigma)
	
	A = double(A);
	
	height = size(A,1);
    width = size(A,2);

	% create an enclosing matrix
	aux = ones(height + 1, width + 1) * 128;
	aux(1:height, 1:width) = A;
	
	for i = 2 : height
		for j = 2 : width
			%dn = sum(sum(aux(i-1:i+1, j-1:j+1) .* [0, 1, 0; 0, -1, 0; 0, 0, 0]));
			%ds = sum(sum(aux(i-1:i+1, j-1:j+1) .* [0, 0, 0; 0, -1, 0; 0, 1, 0]));
			%dw = sum(sum(aux(i-1:i+1, j-1:j+1) .* [0, 0, 0; 1, -1, 0; 0, 0, 0]));
			%de = sum(sum(aux(i-1:i+1, j-1:j+1) .* [0, 0, 0; 0, -1, 1; 0,
			%0, 0]));
			
			north = aux(i+1,j);
    		south = aux(i-1,j);
    		west  = aux(i,j-1);
    		east  = aux(i,j+1);

    		dn =  -(aux(i,j) - north);
    		ds =  -(aux(i,j) - south);
    		dw =  -(aux(i,j) - west);
    		de =  -(aux(i,j) - east);

			cn = lorentz(dn, sigma);
			cs = lorentz(ds, sigma);
			cw = lorentz(dw, sigma);
			ce = lorentz(de, sigma);

    		ret(i,j) = aux(i,j) + lambda * ( cn*dn + cs*ds + ce*de + cw*dw);
		end
	end
	
	ret = uint8(ret);
end

function ret = lorentz(dx, sigma)
	ret = 1 / ((dx*dx) / (sigma*sigma) + 1);
end