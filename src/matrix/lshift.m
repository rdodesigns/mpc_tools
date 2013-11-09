%LSHIFT: Returns the lower shift matrix of size n x n
function L = lshift(n)

  L = circshift(eye(n),[1, 0]);
  L(1,n) = 0;

end
