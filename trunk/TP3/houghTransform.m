function ret = houghTransform(img, edge_detector, threshold, rho_discretization, theta_discretization, epsilon, accumulator_threshold)
	aux = linearHoughTransform(img, edge_detector, threshold, rho_discretization, theta_discretization, epsilon, accumulator_threshold);
	ret.full = aux.hough;
end