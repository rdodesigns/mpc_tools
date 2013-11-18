%FOLDL: Combines list using an accumulator function from left to right.
%
%   foldl(f, s, [x1, x2, x3, ..., xn] => f( (...f(f(f(s, x1),x2),x3), ...), xn)
%
%   Note that the provided foldl is equivalent to the strict version in
%   Haskell, foldl'.
%
%   value = foldl(f, acc, list) takes some list and recursively
%       applies f to the acc "accumulator" value and head of the list,
%       returning a new initial value. f must be a function that takes two
%       inputs (\acc head_list) and returns one output. It traverses the list
%       from left to right.
%
%   acc_with_init = foldl(f, acc) returns a function that takes
%       in a list. It performs the same as above, but with a constant initial
%       acc value and constant f.
%
%   acc = foldl(f) returns a function that takes in an initial acc value
%       and a list. It performs the same as above but with a constant f.
%
%   Examples
%   --------
%       foldl(@plus, 0, 1:10) == 55;
%
%       % The sum function as a fold.
%       sum2 = foldl(@plus, 0);
%       sum2(1:10) == sum(1:10)
%
%       % The prod function as a fold.
%       mult = foldl(@dot, 1);
%       mult(1:10) == prod(1:10)
%
%       % The horizontal cat function as a fold.
%       horzcat2 = foldl(@(x, y) [x y]);
%       horzcat2([1 2], [3 4] ) == [1 2 3 4]
%
%   Algorithm copied from http://goo.gl/HgoAG3
%
%   See also FOLDR, FOLDL1, FOLDR1, BUFFEREDFOLDL, BUFFEREDFOLDR
function out = foldl(accumulator, out, list)

  switch nargin
    case 1, out = @(out, list) foldl(accumulator, out, list);
    case 2, out = @(list) foldl(accumulator, out, list);
    otherwise
      for k=list
        out = accumulator(out,k);
      end
  end

end
