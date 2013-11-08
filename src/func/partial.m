function out = partial(f, varargin)

  args = varargin;
  out = @(varargin) f(args{:}, varargin{:});

end
