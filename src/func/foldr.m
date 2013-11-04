function out = foldr(accumulator, out, list)

  switch nargin
    case 1, out = @(out, list) foldr(accumulator, out, list);
    case 2, out = @(list) foldr(accumulator, out, list);
    otherwise
      for k=fliplr(list)
        out = accumulator(out,k);
      end
  end

end
