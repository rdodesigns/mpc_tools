function out = BufferedFoldr1(accumulator)
  out = @fold;

  rand_key = rand(1)*1e308;
  buffer = rand_key;

  function out = fold(in)
    if nargin == 0
      if buffer == rand_key
        out = [];
      else
        out = buffer;
      end
      return;
    end

    if buffer == rand_key
      buffer = foldr1(accumulator, in);
    else
      buffer = foldr(accumulator, buffer, in);
    end

    out = buffer;
  end

end
