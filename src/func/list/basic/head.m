%HEAD: Take the first element of the list.
function out = head(list)
  if isempty(list)
    error('head:EmptyList', 'head requires a non-empty list');
  end

  out = list(1);
end
