function out = foldl1(accumulator, list)

  switch nargin
    case 1
      out = @(list) foldl(accumulator, list(1), list(2:end));
    otherwise
      out = foldl(accumulator, list(1), list(2:end));
  end

end
