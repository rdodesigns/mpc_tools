function U = ushift(n)
%USHIFT: Returns the upper shift matrix of size nxn

  U = circshift(eye(n),[-1, 0]);
  U(n,1) = 0;

end
