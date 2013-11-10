%CONCATMAP: Map a function over a list and concatenate using horzcat.
%
%   out = concatMap(f, list) maps a function f over a list and concatenates the
%   results. The function must take in one variable and return a list (the list
%   can be one element).
%
%   Examples
%   --------
%
%       list = [1, 2, 3];
%       concatMap(@(y) (y+3), list)
%
%       ans =
%
%            4     5     6
%
%       concatMap(@(y) ([y*4, y^4]), list)
%
%       ans =
%
%            4     1     8    16    12    81

function out = concatMap(f, list)

  switch length(list)
    case 0, out = [];
    case 1, out = f(list);
    otherwise
      out = foldl(@(x,y) (horzcat(x, f(y))), f(list(1)), list(2:end));
  end

end
