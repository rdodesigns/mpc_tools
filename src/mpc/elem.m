function out = elem(x, X)
%ELEM: Check if x is an element of X.
%
%   out = elem(x, X) checks if variable x is an element of the polytope/
%       Polyhedron X. If x is of class sdpvar, then this returns a constraint
%       condition.

  switch class(X)
    case {'Polyhedron', 'polytope'}
      [H, K] = HRep(X);
      out = H*x <= K;
    otherwise
      error('elem:NonPolytopeX', 'X must be either a polytope or Polyhedron');
  end
end
