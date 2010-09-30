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