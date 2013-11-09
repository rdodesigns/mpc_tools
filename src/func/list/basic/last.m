%LAST: Return the last element of a list.
function out = last(list)
  if isempty(list)
    error('last:EmptyList', 'last requires a non-empty list');
  end

  out = list(length(list));

end

