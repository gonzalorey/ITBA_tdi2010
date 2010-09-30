function ret = anisotropicDiffusion(img, lambda, iterations)
	
	% the return value type is the same as the entry image type
	ret = img;
	
	height = size(ret.R,2);
    width = size(ret.R,1);
    
    for k = 1 : iterations
        for i = 2 : width - 1
            for j = 2 : height - 1

                %red pixel
                north = ret.R(i,j-1);
                south = ret.R(i,j+1);
                west  = ret.R(i-1,j);
                east  = ret.R(i+1,j);

                cn =  (ret.R(i,j) - north);
                cs =  (ret.R(i,j) - south);
                cw =  (ret.R(i,j) - west);
                ce =  (ret.R(i,j) - east);

                ret.R(i,j) = ret.R(i,j) + lambda * (north * cn + south * cs + east * ce + west * cw);

                if(ret.R(i,j) < 0)
                    ret.R(i,j) = 0;
                end  

                if(ret.R(i,j) > 255)
                    ret.R(i,j) = 255;
                end

                %green pixel
                north = ret.G(i,j-1);
                south = ret.G(i,j+1);
                west  = ret.G(i-1,j);
                east  = ret.G(i+1,j);

                cn =  (ret.G(i,j) - north);
                cs =  (ret.G(i,j) - south);
                cw =  (ret.G(i,j) - west);
                ce =  (ret.G(i,j) - east);

                ret.G(i,j) = ret.G(i,j) + lambda * (north * cn + south * cs + east * ce + west * cw);

                if(ret.G(i,j) < 0)
                    ret.G(i,j) = 0;
                end  

                if(ret.G(i,j) > 255)
                    ret.G(i,j) = 255;
                end

                %blue pixel
                north = ret.B(i,j-1);
                south = ret.B(i,j+1);
                west  = ret.B(i-1,j);
                east  = ret.B(i+1,j);

                cn =  (ret.B(i,j) - north);
                cs =  (ret.B(i,j) - south);
                cw =  (ret.B(i,j) - west);
                ce =  (ret.B(i,j) - east);

                ret.B(i,j) = ret.B(i,j) + lambda * (north * cn + south * cs + east * ce + west * cw);

                if(ret.B(i,j) < 0)
                    ret.B(i,j) = 0;
                end  

                if(ret.B(i,j) > 255)
                    ret.B(i,j) = 255;
                end
            end
        end
    end
    
    ret.full = ret.R;
    ret.full(:,:,2) = ret.G;
    ret.full(:,:,3) = ret.B;
	
end

function ret = applyAnisotropicMask(A, mask)
	
	% initialize the answer to improve performance
    ret(size(A,1),size(A,2)) = 0;

	% initialize the auxA matrix with the correction of the borders
	auxA = ones(size(A,1) + size(mask,1) - 1, size(A,2) + size(mask,2) - 1) * 128;
    fromX = 1 + (size(mask,1) - 1) / 2;
    toX = 1 + (size(mask,1) - 1) / 2 + (size(A,1) - 1);
    fromY = 1 + (size(mask,2) - 1) / 2;
    toY = 1 + (size(mask,2) - 1) / 2 + (size(A,2) - 1);
    
	auxA(fromX : toX, fromY : toY) = A;

	for i = fromX : toX
		for j = fromY : toY
			
			% get the submatrix to apply the mask to 
			subA = auxA(i - (size(mask,1) - 1) / 2:i + (size(mask,1) - 1) / 2,i - (size(mask,2) - 1) / 2:i + (size(mask,2) - 1) / 2);
			
			% north
			subA(1,2) = subA(1,2) * (auxA(i-1,j) - auxA(i,j));
			
			% south
			subA(3,2) = subA(3,2) * (auxA(i+1,j) - auxA(i,j));
			
			% west
			subA(2,1) = subA(2,1) * (auxA(i,j-1) - auxA(i,j));
			
			% east
			subA(2,3) = subA(2,3) * (auxA(i,j+1) - auxA(i,j));
			
			% total...
			ret(i,j) = sum(sum(double(subA) .* mask));
		end
	end
	
	ret = uint8(ret);
end