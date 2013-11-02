function [H, K] = HRep(P)
% HREP: Return the H representation of a polytope or Polyhedron
%
%   [H, K] = HRep(P) returns the H representation of P. P can be either a
%       polytope or a Polyhedron type object.

  if strcmp(class(P), 'Polyhedron')
    H = P.A; K = P.b;
  elseif strcmp(class(P), 'polytope')
    [H, K] = double(P);
  end

end
