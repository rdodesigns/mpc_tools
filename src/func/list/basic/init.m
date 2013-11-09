%INIT: Take all the elements of the list except the last.
function out = init(list)
  if isempty(list)
    error('init:EmptyList', 'init requires a non-empty list');
  end

  if length(list) == 1
    out = [];
  else
    out = list(1:length(list)-1);
  end

end
