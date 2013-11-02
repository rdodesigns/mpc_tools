function out = isPosInv(A, X)
% ISPOSINV: Check whether an autonomous system is positive invariant.
%
%    bool = ISPOSINV(A, X) calculates whether an autonomous system is
%           positive invariant, using the intersection method. X is either a
%           polytope or Polyhedron type object.

  out = X == intersect(Pre(A, X), X);
end
