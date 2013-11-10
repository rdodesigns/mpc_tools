%CINF: Calculates the C infinity set for a control system.
%
%   C = Cinf(A, X, B, U) returns a Polyhedron that represents the
%       states for a given control system that will lead to a stable controller
%       (there exists a controller such that the resulting states will never
%       leave Cinf if they started in Cinf). A and B are matricies from a
%       discrete system. X and U are Polyhedron representing the constraints of
%       the system.
%
%       NOTE: This algorithm is not guaranteed to converge, and it by default
%       runs for one second.
%
%   [C, converged, iter, time] = Cinf(A, X, B, U) returns a few additional
%       arguments related to the success of the algorith. 'converged' is a
%       boolean that states whether the algorithm converged to a solution.
%       'iter' the iteration that returned the result (for converged results,
%       this is the amount of loops required to calculate Cinf exactly).
%       'time' is the amount of time taken to perform the calculation.
%
%   C = Cinf(A, X, B, U, option_string, option_value) takes in optional
%       parameters. These parameters stack, so if you have a timeout of 100
%       seconds and an iterations of 10, then whichever happens first in a
%       non-converging case will exit the calculation and return C.
%
%       Options
%       -------
%       iterations: The maximum number of iterations to run before giving up
%                   on non-converging cases. This must be a number.
%
%          timeout: How long to attempt the calculation before giving up on
%                   non-converging cases, in seconds. This must be a number.
%
%   See also POLYHEDRON, DLQR

function [C, converged, iter, time] = Cinf(A, X, B, U, varargin)

  try
    catchInputErrors(A, X, B, U);
    opts = parseOptions(varargin);
  catch err
    error(err.identifier, err.message);
  end

  [C, converged, iter, time] = calcCinf(A, X, B, U, opts);

end % end function Cinf


function [C, converged, iter, time] = calcCinf(A, X, B, U, opts)

  % initialize maximum control invariant set Cinf
  C = X;
  time = 0;
  for iter = 1:floor(opts.iterations)

      Cinf_timer = tic;
      % previous estimate of Cinf
      C0 = C;

      % update estimate of Cinf
      C = intersect(Pre(A, C, B, U),C);

      % if set has not changed return Cinf
      converged = C == C0;

      time = toc(Cinf_timer) + time;
      if converged
          break
      end

      if time >= opts.timeout
        break
      end
  end

end % end function calcCinf


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Support Functions                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = catchInputErrors(A, X, B, U)

  if exist('mpt_demo1') ~= 2
    error('Cinf:NoMPTToolbox', 'The MPT toolbox is required for Cinf');
  end

  if ~(strcmp(class(X), 'Polyhedron') || strcmp(class(X), 'polytope'))
    error('Cinf:XNotPolytope', 'X must be a polyhedron or polytope');
  end

  if ~(strcmp(class(U), 'Polyhedron') || strcmp(class(U), 'polytope'))
    error('Cinf:UNotPolytope', 'U must be a polyhedron or polytope');
  end

end


function opts = parseOptions(varin)

  valid_options = {'iterations', 'timeout'};

  % Set default opts.
  opts.iterations = 9223372036854775807;
  opts.timeout = 1;

  if mod(length(varin),2) == 1
    error('Cinf:InvalidNumInputs', ...
          'You must have an even number of variable inputs!');
  end

  for k = 1:length(varin)/2
    option_str = varin{2*k-1};
    option_value = varin{2*k};

    if ~ismember(option_str, valid_options)
      error('Cinf:UnknownOption', ['Unrecognised option: ' option_str]);
    end

    if ~isnumeric(option_value)
      error('Cinf:NonNumericArg', ...
            ['Value of ' option_str ' must be numeric']);
    end

    if strcmp(option_str, 'iterations') && option_value < 1
      error('Cinf:LessOneIteration', 'Must have >=1 iterations');
    end

    if strcmp(option_str, 'timeout') && option_value < 0
      error('Cinf:NegativeTimeout', 'Timeout must be positive');
    end

    opts.(option_str) = option_value;
  end

end
