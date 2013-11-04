function out = isControlInv(A, X, B, U)
% ISCONTROLINV: Check whether a control system is control invariant.
%
%    bool = ISCONTROLINV(A, X, B, U) calculates whether a control system is
%           control invariant, using the intersection method. X and U are
%           either polytope or Polyhedron objects (should be the same type).

  out = X == intersect(Pre(A, X, B, U), X);
end
