function out = zipWith2(f, a, b)

  if length(a) >= length(b)
    len = length(a);
  else
    len = length(b);
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
