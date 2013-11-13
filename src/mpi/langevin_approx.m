function out = langevin_approx(x, n)

  init = (2*n+1);
  xsq = x.^2;
  for k = fliplr(3:2:2*n-1)
    init = k + xsq./init;
  end

  out =  x./init;
end