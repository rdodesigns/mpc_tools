function out = BufferedFoldl(accumulator, initial)
  out = @fold;

  buffer = initial;

  function out = fold(in)
    if nargin == 0
      out = buffer;
      return;
    end

    buffer = foldl(accumulator, buffer, in);
    out = buffer;
  end

end
