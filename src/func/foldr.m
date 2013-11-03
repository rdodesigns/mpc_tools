function out = foldr(accumulator, initial, in)

  out = initial;

  if iscell(in)
    for k=fliplr(1:length(in))
      out = accumulator(out, in{k});
    end
  else
    for k=fliplr(1:length(in))
      out = accumulator(out, in(k));
    end
  end

end
