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
	A = zeros(size(rho,1), size(rho,2));
	
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
    lines_params;
	for i = 1 : size(A, 1)
		for j = 1 : size(A, 2)
			if(A(i, j) > accumulator_threshold)
				k = k + 1;
				lines_params(k, :) = [rho(1, i), theta(j, 1)];
			end
		end
    end

	% obtain the lines
	x = [-100:100];
    lines;
	for i = 1 : size(lines_params,1)
		lines(i,:) = (x * cos(lines_params(i,2)) - lines_params(i,1)) / sin(lines_params(i,2));
	end
	
	plot(x, lines);
	
	% return everything...
	ret.edge_img = edge_img;
	ret.threshold_img = threshold_img;
	ret.rho = rho;
	ret.theta = theta;
	ret.accumulator = A;
	ret.lines_params = lines_params;
	ret.lines = lines;
end