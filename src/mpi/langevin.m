function L = langevin(x)

  L = coth(x) - 1./x;
  
  % Take care of the divide by zero case.
  L(x == 0) = 0;
  
end