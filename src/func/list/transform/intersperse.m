%INTERSPERSE: Intersperses an input between the elements of a list.
function out = intersperse(element, list)
  out = foldl1(@(x,y) (horzcat(x,element,y)), list);
end
