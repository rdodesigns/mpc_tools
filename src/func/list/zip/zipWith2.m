%ZIPWITH2: Zip two lists together is a binary function f.
%
%   list = zipWith2(f, a, b) takes two lists and combines them into a new list,
%       where each element of the new list is the result of the function on the
%       head of the input a and b lists. This is similar to a fold, but in this
%       case using two lists as an input.
%
%   This function can be partially applied. If only one argument is supplied (a
%   function f), then the result is a function that takes two lists and applies
%   the function f to the elements of the two lists. Similarly, filling in two
%   arguments (a function f and a list a) returns a function that takes in a
%   list and applies the function f to the originally supplied a and the input
%   list.
%
%   See also CONCATMAP

function out = zipWith2(f, a, b)

  switch nargin
    case 1, out = @(a, b) zipWith2(f, a, b);
    case 2, out = @(b) zipWith2(f, a, b);
    otherwise
      if length(a) >= length(b)
        len = length(b);
      else
        len = length(a);
      end

      switch len
        case 0, out = [];
        case 1, out = f(a(1), b(1));
        otherwise
          out = f(a(1), b(1));

          for k = 2:len
            out = horzcat(out, f(a(k), b(k)));
          end
      end

    end

end
