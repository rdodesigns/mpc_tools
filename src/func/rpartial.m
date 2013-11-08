function out = rpartial(f, varargin)

  args = varargin;
  out = @(varargin) f(varargin{:}, args{:});

end

