% Algorithm copied from http://goo.gl/HgoAG3
function out = foldl(accumulator, out, list)

  switch nargin
    case 1, out = @(out, list) foldl(accumulator, out, list);
    case 2, out = @(list) foldl(accumulator, out, list);
    otherwise
      for k=list
        out = accumulator(out,k);
      end
  end

end
