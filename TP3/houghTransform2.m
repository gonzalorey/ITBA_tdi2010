function ret = houghTransform(img, edge_detector, threshold, rho_discretization, theta_discretization, epsilon, accumulator_threshold)
	% save the original image
	ret.orig = img;
	
	% edge_detector function: usage => edge_detector(img)
	edge_img = edge_detector(img);
	
	% get the image threshold
	threshold_img = getThreshold(img, threshold);
	
	% discretize theta and rho
	D = max(size(img.full,1), size(img.full,2));
	[rho, theta] = meshgrid([-sqrt(2)*D : 2*sqrt(2)*D/rho_discretization : sqrt(2)*D], [-pi/2:pi/theta_discretization:pi/2]);
	
	% the accumulator
	A = double(zeros(size(rho,1), size(rho,2)));
	
	% apply the linear function
	for x = 1 : size(threshold_img.full, 1)
		for y = 1 : size(threshold_img.full, 2)				
			
			% if it's a white line
			if(threshold_img.full(x,y) == 1)
						
				% apply the linear function
				l = rho - x * cos(theta) - y * sin(theta);
				
				% increment the accumulator		
				A = A + double(abs(l) < epsilon);		
			end
		end
	end
	
	% obtain the lines parameters
	k = 0;
	lines_params = [];
	max_accum = max(max(A)) * accumulator_threshold;
	for i = 1 : size(A, 1)
		for j = 1 : size(A, 2)
			if(A(i, j) > max_accum)
				k = k + 1;
				lines_params(k, :) = [rho(i, j), theta(i, j)];
			end
		end
    end
	
	% create a matrix with the same dimentions as img and set the obtained lines
	h = double(zeros(size(img.full,1), size(img.full,2)));
	for x = 1 : size(h,1)
		for y = 1 : size(h,2)
			for i = 1 : size(lines_params,1)
				if(abs(lines_params(i,1) - x * cos(lines_params(i,2)) - y * sin(lines_params(i,2))) < epsilon)
					h(x,y) = 255;
				end
			end
		end
	end
	
	% return everything...
	ret.edge_img = edge_img;
	ret.threshold_img = threshold_img;
	ret.rho = rho;
	ret.theta = theta;
	ret.accumulator = A;
	ret.lines_params = lines_params;
    ret.hough = h;
end