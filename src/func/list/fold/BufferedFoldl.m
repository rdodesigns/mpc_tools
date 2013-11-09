%BUFFEREDFOLDL: returns a foldl function with a buffer attached.
%
%   foldl = BufferedFoldl(accumulator, initial) returns a foldl function that
%       takes in a list and returns the list folded with its internal buffer.
%       Initial sets up the initial value for the buffer.
%
%   Examples
%   --------
%       step_counter = BufferedFoldl(@plus, 0);
%       step_counter()      % 0
%       step_counter(1)     % 1
%       step_counter()      % 1
%       step_counter(7)     % 8
%       step_counter()      % 8
%       step_counter([1,2]) % 11
%
%   See also FOLDL, FOLDR, FOLDL1, FOLDR1, BUFFEREDFOLDR

function out = BufferedFoldl(accumulator, initial)

  out = @fold;

  buffer = initial;

  function out = fold(in)
    if nargin == 0
      out = buffer;
      return;
    end

    buffer = foldl(accumulator, buffer, in);
    out = buffer;
  end

end
