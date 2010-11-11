function ret = newFFT(newModule, oldPhase)
	ret = newModule .* (cos(oldPhase) + sin(oldPhase) .* i);
end