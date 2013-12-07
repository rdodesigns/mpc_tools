%RPARTIAL: Applies arguments to the right for a function.
%
%   This is best shown by an example. For instance, say we wanted to make a
%   function that always calculates the infinity norm of any input vector. We
%   can do this as follows.
%
%       a = [0.6557, 0.0357, 0.8491, 0.9340, 0.6787, 0.7577, 0.7431, 0.3922];
%       b = [0.7060, 0.0318, 0.2769, 0.0462, 0.0971, 0.8235, 0.6948, 0.3171];
%
%       % Make a function that resolves to norm(a, ...).
%       norm_inf = partial(@norm, Inf);
%
%       % Take a few different types of norms
%       norm_inf(a) % 0.9340
%       norm_inf(b) % 0.8235
%
%   See also PARTIAL.
function out = rpartial(f, varargin)

  args = varargin;
  out = @(varargin) f(varargin{:}, args{:});

end

