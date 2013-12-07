%PARTIAL: Applies arguments to the left for a function.
%
%   This is best shown by an example. For instance, say we wanted to make a
%   function that always calculates the norm of a vector 'a', but we wanted to
%   take several different norms. We can do this as follows.
%
%       a = [0.6557, 0.0357, 0.8491, 0.9340, 0.6787, 0.7577, 0.7431, 0.3922];
%
%       % Make a function that resolves to norm(a, ...).
%       norm_a = partial(@norm, a);
%
%       % Take a few different types of norms
%       norm_a(Inf) % 0.9340
%       norm_a(1)   % 5.0464
%       norm_a()    % 1.9405. The norm with one input is the 2 norm.
%
%   See also RPARTIAL.

function out = partial(f, varargin)

  args = varargin;
  out = @(varargin) f(args{:}, varargin{:});

end
