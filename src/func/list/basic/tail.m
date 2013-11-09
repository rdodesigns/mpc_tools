%TAIL: Return the list without its first element.
function out = tail(list)
  if isempty(list)
    error('tail:EmptyList', 'tail requires a non-empty list');
  end

  if length(list) == 1
    out = [];
  else
    out = list(2:length(list));
  end

end

