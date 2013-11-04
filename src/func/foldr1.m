function out = foldr1(accumulator, list)

  switch nargin
    case 1
      out = @(list) foldr(accumulator, list(1), list(2:end));
    otherwise
      out = foldr(accumulator, list(1), list(2:end));
  end

end
