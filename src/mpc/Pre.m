function out = Pre(A, X, B, U)
%PRE: Calculate the Pre set of an autonomous or control system.
%
%   P = PRE(A, X) caclulates the Pre set for an autonomous system.
%     A: The actions performed on the state space in x(k+1) = Ax. Note
%        that this A should be in discrete form (from the `c2d` function).
%     X: A Polyhedron that describes the constraints on the state space.
%
%   P = PRE(A, X, B, U) calculates the Pre set for a control system.
%     B: The actions performed on the control space in x(k+1) = Ax + Bu. Note
%        that this A should be in discrete form (from the `c2d` function).
%     U: A Polyhedron that describes the constraints on the control space.
%
%   Example:
%
%       % Set up the autonomous system for 2 state variables.
%       A = [1, 0; 0, 1];
%       Hx = [1, 0; -1, 0; 0, 1; 0, -1];
%       Kx = ones(4,1);
%       X = Polyhedron(Hx, Kx);
%
%       % Pre for the autonomous system
%       P = Pre(A, X);
%
%       % Set up the control system for 1 control variable.
%       Hu = [1; -1];
%       Ku = ones(2,1);
%       U = Polyhedron(Hu, Ku);
%
%       % Pre for the control system
%       P = Pre(A, X, B, U);

  if ~ismember(nargin, [2,4])
    error('Can only accept 2 or 4 inputs');
  end

  try
    if nargin == 2
      catch_input_errors(A, X);
    elseif nargin == 4
      catch_input_errors(A, X, B, U);
    end
  catch err
    error(err.identifier, err.message);
  end

  if nargin == 2
    out = PreAuto(A, X);
  elseif nargin == 4
    out = PreControl(A, X, B, U);
  end

end % end function Pre


function out = PreAuto(A, X)

  % Polyhedron half-space representation.
  [Hx, Kx] = HRep(X);

  % projection polytope
  proj = polyTopeOrHedron(Hx*A,Kx, class(X));

  % pre-set
  out = projection(proj,1:size(A,2));

end % end function PreAuto


function out = PreControl(A, X, B, U)

  % polytope half-spaces
  [Hx, Kx] = HRep(X);
  [Hu, Ku] = HRep(U);

  % projection polytope
  XU = polyTopeOrHedron([Hx*A,Hx*B;zeros(size(Hu,1),size(A,1)),Hu],[Kx;Ku], ...
                        class(X));

  % pre-set
  out = projection(XU,1:size(A,2));

end % end function PreControl


function out = polyTopeOrHedron(H, K, type)

  if strcmp(type, 'Polyhedron')
    out = Polyhedron(H, K);
  else
    out = polytope(H, K);
  end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          Support Functions                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = catch_input_errors(A, X, B, U)

  if exist('mpt_demo1') ~= 2
    error('Cinf:NoMPTToolbox', 'The MPT toolbox is required for Cinf');
  end

  if ~(strcmp(class(X), 'Polyhedron') || strcmp(class(X), 'polytope'))
    error('Cinf:XNotPolytope', 'X must be a polyhedron or polytope');
  end

  if nargin == 4
    if ~(strcmp(class(U), 'Polyhedron') || strcmp(class(U), 'polytope'))
      error('Cinf:UNotPolytope', 'U must be a polyhedron or polytope');
    end
  end

end
