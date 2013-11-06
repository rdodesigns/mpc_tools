function L = Lshift(n)
%USHIFT: Returns the upper shift matrix of size nxn

  L = circshift(eye(n),[1, 0]);
  L(1,n) = 0;

end
