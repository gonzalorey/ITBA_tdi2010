function ret = houghTransform(img, edge_detector, threshold, rho_discretization, theta_discretization, epsilon, accumulator_threshold)
	
	% edge_detector function: usage => edge_detector(img)
	edge_img = edge_detector(img);
	
	% get the image threshold
	threshold_img = getThreshold(img, threshold);
	
	% discretize rho
%	D = max(size(img.full,1), size(img.full,2));
%	rho = [-sqrt(2)*D : 2*sqrt(2)*D/rho_discretization : sqrt(2)*D];
	
	% discretize theta
%	theta = [-pi/2 : pi/theta_discretization : pi/2];
	
	% discretize theta and rho
	D = max(size(img.full,1), size(img.full,2));
	[rho, theta] = meshgrid([-sqrt(2)*D : 2*sqrt(2)*D/rho_discretization : sqrt(2)*D], [-pi/2:pi/theta_discretization:pi/2])
	
	% the accumulator
	A = zeros(size(rho,1), size(rho,2));
	
	% apply the linear function
	for ri = 1 : size(rho)
		for ti = 1 : size(theta)
			for x = 1 : size(img.full, 1)
				for y = 1 : size(img.full, 2)
					
					% if it's a white line
					if(img.full(x,y) == 0)
						
						% apply the linear function
						l = rho(ri) - x * cos(theta(ti)) - y * sin(theta(ti));
						
						% if it's smaller than epsilon
						if(l < epsilon)
							
							% increment the accumulator
							A(ri, ti) = A(ri, ti) + 1;
						end
					end
				end
			end
		end
	end
	
	% apply the linear function
	for x = 1 : size(img.full, 1)
		for y = 1 : size(img.full, 2)				
			
			% if it's a white line
			if(img.full(x,y) == 0)
						
				% apply the linear function
				l = rho(ri) - x * cos(theta(ti)) - y * sin(theta(ti));
						
				% if it's smaller than epsilon
				if(l < epsilon)
						
					% increment the accumulator
					A(ri, ti) = A(ri, ti) + 1;
				end
			end
		end
	end
				
	
	k = 0;
	
	% prepare the ret
	for i = 1 : size(A, 1)
		for j = 1 : size(A, 2)
			if(A(i, j) > accumulator_threshold)
				k = k + 1;
				ret(k, :) = [rho(i), theta(j)];
			end
		end
	end
	
end