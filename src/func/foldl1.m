function out = foldl1(accumulator, in)


  if iscell(in)
    out = in{1};

    for k=2:length(in)
      out = accumulator(out, in{k});
    end
  else
    out = in(1);

    for k=2:length(in)
      out = accumulator(out, in(k));
    end
  end

end
