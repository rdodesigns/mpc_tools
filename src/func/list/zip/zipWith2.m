function out = zipWith2(f, a, b)

  switch nargin
    case 1, out = @(a, b) zipWith2(f, a, b);
    case 2, out = @(b) zipWith2(f, a, b);
    otherwise
      if length(a) >= length(b)
        len = length(b);
      else
        len = length(a);
      end

      switch len
        case 0, out = [];
        case 1, out = f(a(1), b(1));
        otherwise
          out = f(a(1), b(1));

          for k = 2:len
            out = horzcat(out, f(a(k), b(k)));
          end
      end

    end

end
