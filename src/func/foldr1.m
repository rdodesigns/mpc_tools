function out = foldr1(accumulator, in)


  if iscell(in)
    out = in{end};

    for k=fliplr(1:length(in)-1)
      out = accumulator(out, in{k});
    end
  else
    out = in(end);

    for k=fliplr(1:length(in)-1)
      out = accumulator(out, in(k));
    end
  end

end
