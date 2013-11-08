%TEE: A buffered pipe. Similar in concept to the UNIX tee command.
%
%   Tee acts as a buffered pipe. It captures its input and returns it as the
%   output. The buffer is a horizontal cell array of the inputs, allowing
%   any type to be captured. Even a series of inputs of different types can be
%   captured!
%
%   This is not thread safe! Do not use with the parallel toolbox! I would need
%   a semaphore, if MATLAB ever provided one. But they suck.
%
%   Creating a new tee buffer
%   -------------------------
%
%   tee = Tee() returns a new unbounded buffered pipe function.
%   tee = Tee(buffer_size) returns a new bounded buffered pipe function. A
%       buffer size of 0 is a bit silly but it means that you capture nothing.
%
%
%   Using the tee buffer
%   --------------------
%
%   tee(input) captures an input into the internal buffer.
%
%   input = tee(input) captures the input and returns a copy as the output.
%
%   [input, buffer] = tee(input) captures the current input and returns both
%       the current input and the current buffer.
%
%   [~, buffer] = tee() returns just the buffer without adding anything.
%
%
%   Convert cell arrays into regular matricies
%   ------------------------------------------
%
%   If the tee was holding a series of matricies (for example, a time series),
%   this can be converted into a block matrix using the following commands.
%   Note that this only works when all of the captured inputs are of the same
%   type.
%
%       [~, buffer] = tee();
%       time_series = horzcat(buffer{:});

function tee = Tee(buffer_size)

  if nargin == 1
    try
      check_input_errors(buffer_size);
    catch err
      error(err.identifier, err.message);
    end
  else
    buffer_size = inf;
  end

  tee = TeeClosure(buffer_size);

end


function closure = TeeClosure(buffer_size)
  buffer = {};
  closure = @tee;

  function [out, current_buffer] = tee(in)

    current_buffer = buffer;

    % If we don't have an input, just return the current buffer. This is a
    % common use pattern to obtain the current buffer.
    if nargin == 0
      out = [];
      return
    end

    % If we don't have a buffer, then the function is a silly pipe!
    if buffer_size == 0
      out = in;
      return
    end

    if isfinite(buffer_size)
      % Chop off the first few elements before appending the new one.
      if length(buffer) >= buffer_size
        % The chopping statement is written using the length of the buffer in
        % case someone attempts to use Tee in a threaded environment.
        buffer = buffer(length(buffer) - buffer_size + 2 : end);
      end
    end

    % Since we had an input and non-zero buffer, concatenate input and return.
    buffer = [buffer, {in}];

    out = in;
    current_buffer = buffer;

  end % end function tee

end % end function TeeClosure

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Support Functions                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = check_input_errors(buffer_size)

  if ~isnumeric(buffer_size)
    error('Tee:NonNumericBufferSize', 'Buffer size must be numeric');
  end

  if buffer_size < 0
    error('Tee:NegativeBufferSize', 'Buffer size must be positive');
  end

  if (buffer_size ~= floor(buffer_size))
    error('Tee:FloatBufferSize', 'Buffer size must be an integer');
  end

end
