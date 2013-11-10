function out = subsequences(list)

  n = length(list);
  subsequence = num2cell(list.',2);

  for k = 2:n
    a = num2cell(list(nchoosek(1:n, k)), 2);
    subsequence = vertcat(subsequence, a);
  end

  out = subsequence';

end
