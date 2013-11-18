%FOLDR: Combines list using an f function from right to left.
%
%   foldr(f, s, [x1, ...,  xn] =>  f x1 (f x2 (f x3 (...(f xn z) ...)))
%
%   value = foldl(f, acc, list) takes some list and recursively
%       applies the f function to the acc value and the end element of the
%       list, returning a new acc value. The f must be a function that takes
%       two inputs (of form  \last_list acc) and returns one accput. It
%       traverses the list from right to left.
%
%   acc_with_init = foldl(f, acc) returns a function that takes
%       in a list. It performs the same as above, but with a constant acc
%       value and constant f function.
%
%   acc = foldl(f) returns a function that takes in an acc value
%       and a list. It performs the same as above but with a constant
%       f function.
%
%   Examples
%   --------
%       foldr(@plus, 0, 1:10) == 55;
%
%       % The sum function as a fold.
%       sum2 = foldr(@plus, 0);
%       sum2(1:10) == sum(1:10)
%
%       % The prod function as a fold.
%       mult = foldr(@dot, 1);
%       mult(1:10) == prod(1:10)
%
%       % The horizontal cat function as a fold.
%       horzcat2 = foldr(@(x, y) [x y]);
%       horzcat2([1 2], [3 4] ) == [1 2 3 4]
%
%   Algorithm copied from http://goo.gl/HgoAG3
%
%   See also FOLDL, FOLDL1, FOLDR1, BUFFEREDFOLDL, BUFFEREDFOLDR

function acc = foldr(f, acc, list)

  switch nargin
    case 1, acc = @(acc, list) foldr(f, acc, list);
    case 2, acc = @(list) foldr(f, acc, list);
    otherwise
      for k=fliplr(list)
        acc = f(k, acc);
      end
  end

end
