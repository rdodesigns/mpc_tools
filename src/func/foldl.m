function out = foldl(accumulator, initial, in)

  out = initial;

  if iscell(in)
    for k=1:length(in)
      out = accumulator(out, in{k});
    end
  else
    for k=1:length(in)
      out = accumulator(out, in(k));
    end
  end

end
