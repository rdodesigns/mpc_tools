function dL = dlangevin(x)

  dL = 1./x.^2 - coth(x).^2 + 1;

  % Take care of the divide by zero case.
  dL(x == 0) = 1/3;
  
end