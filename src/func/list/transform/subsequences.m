%SUBSEQUENCES: Return all subsequences of an input list.
%
%   Enumerates all the subsequnces of an input list. The result is a cell
%   array. Do not use of lists larger than 15 elements.
%
%   For example
%
%       a = 'abc';
%
%       subsequences(a)
%
%       ans =
%
%           'a'    'b'    'c'    'ab'    'ac'    'bc'    'abc'

function out = subsequences(list)

  n = length(list);

  %% Add each element to the subsequent list, since nchoosek will not do this.
  subsequence = num2cell(list.',2);

  for k = 2:n
    a = num2cell(list(nchoosek(1:n, k)), 2);
    subsequence = vertcat(subsequence, a);
  end

  out = subsequence';

end
