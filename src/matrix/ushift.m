%USHIFT: Returns the upper shift matrix of size n x n
function U = ushift(n)

  U = circshift(eye(n),[-1, 0]);
  U(n,1) = 0;

end
