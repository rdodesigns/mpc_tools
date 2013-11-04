function out = foldl1(accumulator, list)
%FOLDL1: Same as foldl but does not need an initial value.
%
%   See also FOLDL, FOLDR, FOLDR1, BUFFEREDFOLDL, BUFFEREDFOLDR

  switch nargin
    case 1
      out = @(list) foldl(accumulator, list(1), list(2:end));
    otherwise
      out = foldl(accumulator, list(1), list(2:end));
  end

end
