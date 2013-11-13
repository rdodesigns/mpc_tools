function out = dlangevinLSI(amplitude, fwhm, x0, x)
  fwhm0 = 4.161048048380302;
  out = 3*amplitude*dlangevin(fwhm0/fwhm*(xdata-x0))
end
